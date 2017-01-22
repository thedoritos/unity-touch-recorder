//
//  UTFTouch.m
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import "UTFTouch.h"

@implementation UTFTouch

+(instancetype)create:(UITouch *)touch
{
    UTFTouch *fake = [UTFTouch new];
    
    fake.fakeTimestamp = touch.timestamp;
    fake.fakePhase = touch.phase;
    fake.fakeTapCount = touch.tapCount;
    fake.fakeWindow = touch.window;
    fake.fakeView = touch.view;
    
    fake.fakeLocation = [touch locationInView:touch.view];
    fake.fakePreviousLocation = [touch previousLocationInView:touch.view];
    
    return fake;
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

@end
