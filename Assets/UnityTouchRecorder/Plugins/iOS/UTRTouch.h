//
//  UTRTouch.h
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import <UIKit/UIKit.h>

@interface UTRTouch : UITouch

@property(nonatomic) NSTimeInterval fakeTimestamp;
@property(nonatomic) UITouchPhase fakePhase;
@property(nonatomic) NSUInteger fakeTapCount;
@property(nonatomic) UITouchType fakeType;

@property(nonatomic) UIWindow *fakeWindow;
@property(nonatomic) UIView *fakeView;

@property(nonatomic) CGPoint fakeLocation;
@property(nonatomic) CGPoint fakePreviousLocation;

@property(nonatomic) NSString *originalTouchMemoryAddress;

+(instancetype)create:(UITouch *)touch;
-(instancetype)clone;

+(instancetype)createSet:(NSSet *)set;

-(void)delay:(NSTimeInterval)delay;
-(void)update:(UTRTouch *)touch;

@end
