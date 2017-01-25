//
//  UTRTouchSet.m
//  Unity-iPhone
//
//  Created by t-matsumura on 1/25/17.
//
//

#import "UTRTouchSet.h"
#import "UTRTouch.h"

@implementation UTRTouchSet

+(instancetype)create
{
    UTRTouchSet *instance = [UTRTouchSet new];
    instance.set = [NSMutableSet new];
    return instance;
}

-(NSSet *)touches
{
    return _set;
}

-(void)update:(NSSet *)touches
{
    NSSet *allTouches = [NSSet setWithSet:_set];
    
    [_set removeAllObjects];
    for (UTRTouch *t in allTouches) {
        if (t.phase != UITouchPhaseEnded) {
            [_set addObject:t];
        }
    }
    
    NSInteger deleteCount = allTouches.count - _set.count;
    if (deleteCount > 0) {
        NSLog(@"UTRRecorder#UTRTouchSet#deleted:%ld", (long)deleteCount);
    }
    
    for (UTRTouch *newTouch in touches) {
        BOOL updated = NO;
        for (UTRTouch *t in _set) {
            NSLog(@"UTRRecorder#UTRTouchSet#mem_old:%@", t.originalTouchMemoryAddress);
            NSLog(@"UTRRecorder#UTRTouchSet#mem_new:%@", newTouch.originalTouchMemoryAddress);
            
            if ([newTouch isEqual:t]) {
                [t update:newTouch];
                updated = YES;
                break;
            }
        }
        
        NSLog(@"UTRRecorder#UTRTouchSet#updated:%@", updated ? @"YES" : @"NO");
        
        if (!updated) {
            [_set addObject:[newTouch clone]];
        }
    }
}

@end
