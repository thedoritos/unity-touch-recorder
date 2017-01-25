using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;
using System.Linq;

namespace UnityTouchRecorder.Sample
{
    public class DemoTouchLogger : MonoBehaviour
    {
        [SerializeField]
        Text log;

        [SerializeField]
        int logLength = 100;

        private Queue<string> messages = new Queue<string>();

        void Update()
        {
            var touches = Input.touches;
            if (touches.Length == 0)
            {
                return;
            }

            var message = touches.Select(t =>
            {
                return string.Format("fingerId:{0}\tphase:{1}\tposition:{2}", t.fingerId, t.phase, t.position);
            }).Aggregate((t1, t2) =>
            {
                return t1 + " & " + t2;
            });

            messages.Enqueue(message);

            while (messages.Count > logLength && messages.Count > 0)
            {
                messages.Dequeue();
            }

            log.text = messages.Aggregate((m1, m2) => m1 + "\n" + m2);

            Debug.Log(message);
        }
    }
}