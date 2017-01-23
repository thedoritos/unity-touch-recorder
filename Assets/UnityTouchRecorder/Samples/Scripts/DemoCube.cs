using UnityEngine;
using System.Collections.Generic;
using System.Linq;

namespace UnityTouchRecorder.Sample
{
    public class DemoCube : MonoBehaviour
    {
        [SerializeField]
        private int fingerId;

        private Vector3 rotationVector;

        void Update()
        {
            rotationVector = Vector3.Lerp(this.rotationVector, Vector3.zero, 0.3f);
            transform.Rotate(rotationVector);

            var touches = Input.touches.Where(t => t.fingerId == fingerId);
            if (touches.Count() == 0)
            {
                return;
            }

            var touch = touches.First();
            rotationVector = touch.deltaPosition * touch.deltaTime * 10;
        }
    }
}