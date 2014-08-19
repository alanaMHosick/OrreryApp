//
//  bodyPosition.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/17/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Planet;
@interface BodyPosition : NSObject
+ (double)calculateAngleX:(double)x Y:(double)y;
+(Planet *)findEarthCenteredVars:(Planet *)p Earth:(Planet *)earth Sun:(Planet *)star Date:(NSDate *)date;
+ (long double)rad:(double)deg;
+ (long double)deg:(double)rad;
+ (long double)hours:(double)degrees;
@end
