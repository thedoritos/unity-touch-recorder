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
                    view.StopButton.gameObject.SetActive(true);

                    plugin.Clear();
                    plugin.StartRecording();
                });

            view.PlayButton.onClick.AddListener(() =>
                {
                    view.SetMenuActive(false);

                    view.OpenMenuButton.gameObject.SetActive(false);
                    view.StopButton.gameObject.SetActive(true);

                    plugin.Play(view.Repeat, view.Interval);
                });
            
            view.StopButton.onClick.AddListener(() =>
                {
                    view.OpenMenuButton.gameObject.SetActive(true);
                    view.StopButton.gameObject.SetActive(false);

                    plugin.StopRecording();
                    plugin.Stop();
                });
        }
    }
}