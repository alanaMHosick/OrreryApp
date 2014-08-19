//
//  Math.h
//  Space
//
//  Created by Alana Hosick on 1/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Planet;
@interface Math : NSObject

+ (NSString *)calculateDistanceX1:(double)x1 Y1:(double)y1 Z1:(double)z1 X2:(double)x2 Y2:(double)y2 Z2:(double)z2;

+ (double)calculateAngleX:(double)x Y:(double)y;

+ (NSString *)getCurrentDate;
+ (NSString *)formatDate:(NSDate *)date;
+ (NSString *)getDay:(NSDate *)date;
+ (NSArray *)timeFromSeconds:(long)numberOfSeconds;
+ (NSString *)getMonth:(NSDate *)date;
+ (Planet *)findZenithPlanet:(Planet *)planet Earth:(Planet *)earth Sun:(Planet *)sun;
+ (double)findPolarAnglePlanet:(Planet *)p Earth:(Planet *)earth Sun:(Planet *)star;

+ (double) riseSecondsPlanet:(Planet *)planet Sunrise:(double)sunrise;
+ (double) setSecondsPlanet:(Planet *)planet Sunset:(double)sunset;



@end
