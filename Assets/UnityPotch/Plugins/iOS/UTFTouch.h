//
//  UTFTouch.h
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import <UIKit/UIKit.h>

@interface UTFTouch : UITouch

@property(nonatomic) NSTimeInterval fakeTimestamp;
@property(nonatomic) UITouchPhase fakePhase;
@property(nonatomic) NSUInteger fakeTapCount;
@property(nonatomic) UIWindow *fakeWindow;
@property(nonatomic) UIView *fakeView;

@property(nonatomic) CGPoint fakeLocation;
@property(nonatomic) CGPoint fakePreviousLocation;

+(instancetype)create:(UITouch *)touch;

-(void)delay:(NSTimeInterval)delay;

@end
