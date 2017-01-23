//
//  UTREvent.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UTREvent.h"
#import "UTRTouch.h"

@implementation UTREvent

+(instancetype)create:(UIEvent *)event phase:(UITouchPhase)phase
{
    UTREvent *fake = [UTREvent new];
    fake.phase = phase;
    
    fake.fakeTimestamp = event.timestamp;
    
    NSMutableSet *touches = [NSMutableSet new];
    for (UITouch *touch in event.allTouches) {
        [touches addObject:[UTRTouch create:touch]];
    }
    fake.fakeAllTouches = touches;
    
    return fake;
}

-(void)delay:(NSTimeInterval)delay
{
    _fakeTimestamp += delay;
    for (UTRTouch *touch in _fakeAllTouches) {
        [touch delay:delay];
    }
}

- (NSTimeInterval)timestamp
{
    return _fakeTimestamp;
}

- (nullable NSSet <UITouch *> *)allTouches
{
    return _fakeAllTouches;
}

@end
