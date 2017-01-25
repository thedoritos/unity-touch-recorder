//
//  UTRTouch.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UTRTouch.h"

@implementation UTRTouch

+(instancetype)create:(UITouch *)touch
{
    UTRTouch *fake = [UTRTouch new];
    
    fake.fakeTimestamp = touch.timestamp;
    fake.fakePhase = touch.phase;
    fake.fakeTapCount = touch.tapCount;
    fake.fakeType = touch.type;
    
    fake.fakeWindow = touch.window;
    fake.fakeView = touch.view;
    
    fake.fakeLocation = [touch locationInView:touch.view];
    fake.fakePreviousLocation = [touch previousLocationInView:touch.view];
    
    fake.originalTouchMemoryAddress = [NSString stringWithFormat:@"%p", touch];

    return fake;
}

+(instancetype)createSet:(NSSet *)set
{
    NSMutableSet *instance = [NSMutableSet new];
    for (UITouch *t in set) {
        [instance addObject:[UTRTouch create:t]];
    }
    return instance;
}

-(instancetype)clone
{
    UTRTouch *clone = [UTRTouch new];
    
    clone.fakeTimestamp = self.fakeTimestamp;
    clone.fakePhase = self.fakePhase;
    clone.fakeTapCount = self.fakeTapCount;
    clone.fakeWindow = self.fakeWindow;
    clone.fakeView = self.fakeView;
    
    clone.fakeLocation = self.fakeLocation;
    clone.fakePreviousLocation = self.fakePreviousLocation;
    
    clone.originalTouchMemoryAddress = self.originalTouchMemoryAddress;
    
    return clone;
}

-(void)update:(UTRTouch *)touch
{
    self.fakeTimestamp = touch.timestamp;
    self.fakePhase = touch.phase;
    self.fakeTapCount = touch.tapCount;
    self.fakeWindow = touch.window;
    self.fakeView = touch.view;
    
    self.fakeLocation = [touch locationInView:touch.view];
    self.fakePreviousLocation = [touch previousLocationInView:touch.view];
}

-(void)delay:(NSTimeInterval)delay
{
    _fakeTimestamp += delay;
}

- (NSTimeInterval)timestamp
{
    return _fakeTimestamp;
}

- (UITouchPhase)phase
{
    return _fakePhase;
}

- (NSUInteger)tapCount
{
    return _fakeTapCount;
}

- (UITouchType)type
{
    return _fakeType;
}

- (UIWindow *)window
{
    return _fakeWindow;
}

- (UIView *)view
{
    return _fakeView;
}

- (CGPoint)locationInView:(nullable UIView *)view
{
    return [_fakeView convertPoint:_fakeLocation toView:view];
}

- (CGPoint)previousLocationInView:(nullable UIView *)view
{
    return [_fakeView convertPoint:_fakePreviousLocation toView:view];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:self.class]) {
        return NO;
    }
    
    UTRTouch *touch = (UTRTouch *)object;
    return [touch.originalTouchMemoryAddress isEqualToString:self.originalTouchMemoryAddress];
}

-(NSSet *)mergeSet:(NSSet *)set into:(NSSet *)base
{
    NSMutableSet *merged = [NSMutableSet setWithSet:base];
    for (UTRTouch *newTouch in set) {
        BOOL updated = NO;
        
        for (UTRTouch *baseTouch in merged) {
            if ([newTouch isEqual:baseTouch]) {
                [baseTouch update:newTouch];
                break;
            }
        }
    }
}

@end
