using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Assertions;

namespace UnityTouchRecorder
{
    public class TouchRecorderView : MonoBehaviour
    {
        [SerializeField]
        Button openMenuButton;

        [SerializeField]
        Button startRecordingButton;

        [SerializeField]
        Button stopRecordingButton;

        [SerializeField]
        Button playButton;

        [SerializeField]
        Button stopButton;

        [SerializeField]
        InputField playRepeatInputField;

        [SerializeField]
        InputField playIntervalInputField;

        [SerializeField]
        Button resetButton;

        [SerializeField]
        GameObject menuPanel;

        public Button OpenMenuButton { get { return openMenuButton; } }

        public Button StartRecordingButton { get { return startRecordingButton; } }

        public Button StopRecordingButton { get { return stopRecordingButton; } }

        public Button PlayButton { get { return playButton; } }

        public Button StopButton { get { return stopButton; } }

        public Button ResetButton { get { return resetButton; } }

        public int Repeat
        {
            get
            {
                int val = 0;
                int.TryParse(playRepeatInputField.text, out val);
                return val;
            }
        }

        public float Interval
        {
            get
            {
                float val = 0.0f;
                float.TryParse(playIntervalInputField.text, out val);
                return val;
            }
        }

        public bool IsMenuActive { get { return menuPanel.activeSelf; } }

        public void SetMenuActive(bool active)
        {
            menuPanel.SetActive(active);
        }
    }
}