//
//  UTREvent.h
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import <UIKit/UIKit.h>

@interface UTREvent : UIEvent

@property (nonatomic) UITouchPhase phase;

@property (nonatomic) NSTimeInterval fakeTimestamp;
@property (nonatomic) NSSet *fakeAllTouches;

+(instancetype)create:(UIEvent *)event phase:(UITouchPhase)phase;

-(void)delay:(NSTimeInterval)delay;

@end
