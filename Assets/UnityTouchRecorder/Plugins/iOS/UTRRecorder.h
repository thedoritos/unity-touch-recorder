//
//  UTRRecorder.h
//  Unity-iPhone
//
//  Created by thedoritos on 1/22/17.
//
//

#import <Foundation/Foundation.h>

@interface UTRRecorder : NSObject

@property(nonatomic) BOOL recording;
@property(nonatomic) BOOL playing;

@property(nonatomic) NSMutableArray *events;
@property(nonatomic) NSMutableArray *touches;

+(instancetype)sharedRecorder;

-(void)startRecording;
-(void)stopRecording;

-(void)record:(NSSet *)touches event:(UIEvent *)event phase:(UITouchPhase)phase;
-(NSUInteger)count;

-(void)play:(NSUInteger)repeat interval:(float)interval;
-(void)stop;
-(void)clear;

@end
