//
//  UnityView+UTRHook.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UnityView+UTRHook.h"
#import "UTRRecorder.h"

@implementation UnityView(UTRHook)

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
#if UNITY_TVOS_SIMULATOR_FAKE_REMOTE
    ReportSimulatedRemoteTouchesBegan(self, touches);
#endif
#if UNITY_TVOS
    if (UnityGetAppleTVRemoteTouchesEnabled())
#endif
        [[UTRRecorder sharedRecorder] record:touches event:event phase:UITouchPhaseBegan];
    
    UnitySendTouchesBegin(touches, event);
}
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
#if UNITY_TVOS_SIMULATOR_FAKE_REMOTE
    ReportSimulatedRemoteTouchesEnded(self, touches);
#endif
#if UNITY_TVOS
    if (UnityGetAppleTVRemoteTouchesEnabled())
#endif
    [[UTRRecorder sharedRecorder] record:touches event:event phase:UITouchPhaseEnded];
    
    UnitySendTouchesEnded(touches, event);
}
- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
#if UNITY_TVOS_SIMULATOR_FAKE_REMOTE
    ReportSimulatedRemoteTouchesEnded(self, touches);
#endif
#if UNITY_TVOS
    if (UnityGetAppleTVRemoteTouchesEnabled())
#endif
    [[UTRRecorder sharedRecorder] record:touches event:event phase:UITouchPhaseCancelled];
    
    UnitySendTouchesCancelled(touches, event);
}
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
#if UNITY_TVOS_SIMULATOR_FAKE_REMOTE
    ReportSimulatedRemoteTouchesMoved(self, touches);
#endif
#if UNITY_TVOS
    if (UnityGetAppleTVRemoteTouchesEnabled())
#endif
    [[UTRRecorder sharedRecorder] record:touches event:event phase:UITouchPhaseMoved];
    
    UnitySendTouchesMoved(touches, event);
}

@end
