//
//  UTFEvent.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UTFEvent.h"
#import "UTFTouch.h"

@implementation UTFEvent

+(instancetype)create:(UIEvent *)event phase:(UITouchPhase)phase
{
    UTFEvent *fake = [UTFEvent new];
    fake.phase = phase;
    
    fake.fakeTimestamp = event.timestamp;
    
    NSMutableSet *touches = [NSMutableSet new];
    for (UITouch *touch in event.allTouches) {
        [touches addObject:[UTFTouch create:touch]];
    }
    fake.fakeAllTouches = touches;
    
    return fake;
}

-(void)delay:(NSTimeInterval)delay
{
    _fakeTimestamp += delay;
    for (UTFTouch *touch in _fakeAllTouches) {
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
