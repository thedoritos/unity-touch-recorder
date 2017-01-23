using UnityEngine;

namespace UnityTouchRecorder
{
    public class TouchRecorderController : MonoBehaviour
    {
        UnityTouchRecorderPlugin plugin = new UnityTouchRecorderPlugin();

        [SerializeField]
        TouchRecorderView view;

        void Awake()
        {
            Object.DontDestroyOnLoad(gameObject);

            view.OpenMenuButton.onClick.AddListener(() =>
                {
                    view.SetMenuActive(!view.IsMenuActive);
                });

            view.StartRecordingButton.onClick.AddListener(() =>
                {
                    view.SetMenuActive(false);

                    view.OpenMenuButton.gameObject.SetActive(false);
                    view.StopRecordingButton.gameObject.SetActive(true);
                    view.StopButton.gameObject.SetActive(false);

                    plugin.Clear();
                    plugin.StartRecording();
                });

            view.StopRecordingButton.onClick.AddListener(() =>
                {
                    view.OpenMenuButton.gameObject.SetActive(true);
                    view.StopRecordingButton.gameObject.SetActive(false);
                    view.StopButton.gameObject.SetActive(false);

                    plugin.StopRecording();
                });

            view.PlayButton.onClick.AddListener(() =>
                {
                    view.SetMenuActive(false);

                    view.OpenMenuButton.gameObject.SetActive(false);
                    view.StopRecordingButton.gameObject.SetActive(false);
                    view.StopButton.gameObject.SetActive(true);

                    plugin.Play(view.Repeat, view.Interval);
                });
            
            view.StopButton.onClick.AddListener(() =>
                {
                    view.OpenMenuButton.gameObject.SetActive(true);
                    view.StopRecordingButton.gameObject.SetActive(false);
                    view.StopButton.gameObject.SetActive(false);

                    plugin.Stop();
                });
        }
    }
}