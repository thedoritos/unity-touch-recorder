//
//  UTRRecorder.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UTRRecorder.h"
#import "UTREvent.h"

@implementation UTRRecorder

+(instancetype)sharedRecorder
{
    static UTRRecorder *recorder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recorder = [UTRRecorder new];
        recorder.recording = NO;
        recorder.playing = NO;
        recorder.events = [NSMutableArray new];
    });
    return recorder;
}

-(void)startRecording
{
    if (self.recording || self.playing) {
        return;
    }
    self.recording = YES;
}

-(void)stopRecording
{
    if (!self.recording) {
        return;
    }
    self.recording = NO;
}

-(void)record:(UIEvent *)event phase:(UITouchPhase)phase
{
    if (!self.recording) {
        return;
    }
    
    [self.events addObject:[UTREvent create:event phase:phase]];
}

-(NSUInteger)count
{
    return self.events.count;
}

-(void)play:(NSUInteger)repeat interval:(float)interval
{
    if (self.recording || self.playing) {
        return;
    }
    self.playing = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(NSUInteger i = 0; i < repeat; i++) {
            NSArray *items = [NSArray arrayWithArray:self.events];
            UTREvent *first = items.firstObject;
            NSTimeInterval delay = [[NSDate date] timeIntervalSince1970] - first.timestamp;
            
            for (UTREvent *e in items) {
                [e delay:delay];
            }
            
            for (UTREvent *e in items) {
                if (!self.playing) {
                    return;
                }
                
                [NSThread sleepForTimeInterval:e.timestamp - [[NSDate date] timeIntervalSince1970]];
                
                if (!self.playing) {
                    return;
                }
                
                switch (e.phase) {
                    case UITouchPhaseBegan:
                        UnitySendTouchesBegin(e.allTouches, e);
                        break;
                    case UITouchPhaseEnded:
                        UnitySendTouchesEnded(e.allTouches, e);
                        break;
                    case UITouchPhaseCancelled:
                        UnitySendTouchesCancelled(e.allTouches, e);
                        break;
                    case UITouchPhaseMoved:
                        UnitySendTouchesMoved(e.allTouches, e);
                        break;
                    default:
                        break;
                }
            }
            
            [NSThread sleepForTimeInterval:interval];
        }
        
        [self stop];
    });
}

-(void)stop
{
    if (self.recording || !self.playing) {
        return;
    }
    self.playing = NO;
}

-(void)clear
{
    if (self.recording) {
        return;
    }
    
    [self.events removeAllObjects];
}

@end
