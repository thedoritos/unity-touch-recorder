using UnityEngine;
using System.Runtime.InteropServices;

namespace UnityTouchRecorder
{
    public class UnityTouchRecorderPlugin
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

        public void StartRecording()
        {
            UnityTouchRecorderPlugin_StartRecording();
        }

        public void StopRecording()
        {
            UnityTouchRecorderPlugin_StopRecording();
        }

        public void Play(int repeat, float interval)
        {
            UnityTouchRecorderPlugin_Play(repeat, interval);
        }

        public void Stop()
        {
            UnityTouchRecorderPlugin_Stop();
        }

        public void Clear()
        {
            UnityTouchRecorderPlugin_Clear();
        }
    }
}