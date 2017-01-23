//
//  UnityTouchRecorderPlugin.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UnityTouchRecorderPlugin.h"
#import "UTRRecorder.h"

@implementation UnityTouchRecorderPlugin

extern "C" {
    void UnityTouchRecorderPlugin_StartRecording() {
        UTRRecorder *recorder = [UTRRecorder sharedRecorder];
        [recorder startRecording];
    }
    
    void UnityTouchRecorderPlugin_StopRecording() {
        UTRRecorder *recorder = [UTRRecorder sharedRecorder];
        [recorder stopRecording];
    }
    
    void UnityTouchRecorderPlugin_Play(int repeat, float interval) {
        UTRRecorder *recorder = [UTRRecorder sharedRecorder];
        [recorder play:(NSUInteger)repeat interval:interval];
    }
    
    void UnityTouchRecorderPlugin_Stop() {
        UTRRecorder *recorder = [UTRRecorder sharedRecorder];
        [recorder stop];
    }
    
    void UnityTouchRecorderPlugin_Clear() {
        UTRRecorder *recorder = [UTRRecorder sharedRecorder];
        [recorder clear];
    }
}

@end
