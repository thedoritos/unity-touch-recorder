//
//  UTRTouchSet.h
//  Unity-iPhone
//
//  Created by t-matsumura on 1/25/17.
//
//

#import <Foundation/Foundation.h>

@interface UTRTouchSet : NSObject

@property(nonatomic) NSMutableSet *set;

+(instancetype)create;

-(NSSet *)touches;

-(void)update:(NSSet *)touches;

@end
