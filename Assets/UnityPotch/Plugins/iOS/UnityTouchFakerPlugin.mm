//
//  UnityTouchFakerPlugin.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UnityTouchFakerPlugin.h"
#import "UTFRecorder.h"

@implementation UnityTouchFakerPlugin

extern "C" {
    void UnityTouchFakerPlugin_StartRecording() {
        UTFRecorder *recorder = [UTFRecorder sharedRecorder];
        [recorder startRecording];
    }
    
    void UnityTouchFakerPlugin_StopRecording() {
        UTFRecorder *recorder = [UTFRecorder sharedRecorder];
        [recorder stopRecording];
    }
    
    void UnityTouchFakerPlugin_Play(int repeat, float interval) {
        UTFRecorder *recorder = [UTFRecorder sharedRecorder];
        [recorder play:(NSUInteger)repeat interval:interval];
    }
    
    void UnityTouchFakerPlugin_Stop() {
        UTFRecorder *recorder = [UTFRecorder sharedRecorder];
        [recorder stop];
    }
    
    void UnityTouchFakerPlugin_Clear() {
        UTFRecorder *recorder = [UTFRecorder sharedRecorder];
        [recorder clear];
    }
}

@end
