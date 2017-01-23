using UnityEngine;
using UnityEngine.UI;
using System.Runtime.InteropServices;

namespace Kakera
{
    public class PotchManager : MonoBehaviour
    {
        [DllImport("__Internal")]
        private static extern void UnityTouchRecorderPlugin_StartRecording();

        [DllImport("__Internal")]
        private static extern void UnityTouchRecorderPlugin_StopRecording();

        [DllImport("__Internal")]
        private static extern void UnityTouchRecorderPlugin_Play(int repeat, float interval);

        [DllImport("__Internal")]
        private static extern void UnityTouchRecorderPlugin_Stop();

        [DllImport("__Internal")]
        private static extern void UnityTouchRecorderPlugin_Clear();

        [SerializeField]
        GameObject recordingPanel;

        [SerializeField]
        InputField repeatInputField;

        [SerializeField]
        InputField intervalInputField;

        public void OnTogglePanel()
        {
            recordingPanel.SetActive(!recordingPanel.activeSelf);
        }

        public void OnClickStartRecording()
        {
            recordingPanel.SetActive(false);

            UnityTouchRecorderPlugin_StartRecording();
        }

        public void OnClickStopRecording()
        {
            UnityTouchRecorderPlugin_StopRecording();
        }

        public void OnClickStartPlaying()
        {
            int repeat;
            var success = int.TryParse(repeatInputField.text, out repeat);
            if (!success)
            {
                Debug.LogError(string.Format("Repeat is not a number: {0}", repeatInputField.text));
                return;
            }

            float interval;
            success = float.TryParse(intervalInputField.text, out interval);
            if (!success)
            {
                Debug.LogError(string.Format("Interval is not a number: {0}", intervalInputField.text));
                return;
            }

            recordingPanel.SetActive(false);

            UnityTouchRecorderPlugin_Play(repeat, 5.0f);
        }
    }
}
