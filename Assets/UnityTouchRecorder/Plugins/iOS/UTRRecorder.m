//
//  UTRRecorder.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UTRRecorder.h"
#import "UTREvent.h"
#import "UTRTouch.h"
#import "UTRTouchSet.h"

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
        recorder.touches = [NSMutableArray new];
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

-(void)record:(NSSet *)touches event:(UIEvent *)event phase:(UITouchPhase)phase
{
    if (!self.recording) {
        return;
    }
    
    [self.touches addObject:[UTRTouch createSet:touches]];
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
            UTRTouchSet *touchSet = [UTRTouchSet create];
            UTRTouchSet *allTouchSet = [UTRTouchSet create];
            
            NSArray *items = [NSArray arrayWithArray:self.events];
            UTREvent *first = items.firstObject;
            NSTimeInterval delay = [[NSProcessInfo processInfo] systemUptime] - first.timestamp;
            
            for (UTREvent *e in items) {
                [e delay:delay];
            }
            for (NSSet *ts in self.touches) {
                for (UTRTouch *t in ts) {
                    [t delay:delay];
                }
            }
            
            for (NSInteger index = 0; index < items.count; index++) {
                UTREvent *e = items[index];
                NSSet *t =self.touches[index];
                
                NSLog(@"UTR#self.touches.count:%lu", (unsigned long)self.touches.count);
                
                if (!self.playing) {
                    return;
                }
                
                [touchSet update:t];
//                [allTouchSet update:e.allTouches];
                
                [NSThread sleepForTimeInterval:e.timestamp - [[NSProcessInfo processInfo] systemUptime]];
                
                if (!self.playing) {
                    return;
                }
                
                switch (e.phase) {
                    case UITouchPhaseBegan:
                        NSLog(@"UTRRecorder#began");
                        UnitySendTouchesBegin(touchSet.touches, e);
                        break;
                    case UITouchPhaseEnded:
                        NSLog(@"UTRRecorder#ended");
                        UnitySendTouchesEnded(touchSet.touches, e);
                        break;
                    case UITouchPhaseCancelled:
                        NSLog(@"UTRRecorder#cancelled");
                        UnitySendTouchesCancelled(touchSet.touches, e);
                        break;
                    case UITouchPhaseMoved:
                        NSLog(@"UTRRecorder#moved");
                        UnitySendTouchesMoved(touchSet.touches, e);
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
