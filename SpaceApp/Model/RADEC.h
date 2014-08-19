//
//  RADEC.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/18/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Planet;
@interface RADEC : NSObject

//+ (Planet *) riseSet:(Planet *)planet Longitude:(double)geoLong Latitude:(double)geoLat Date:(NSDate *)date;
//+ (Planet *) estimateRADEC:(Planet *)planet Angle:(double)angle;
+ (Planet *) riseSet:(Planet *)planet Earth:(Planet *)earth Star:(Planet *)sun Longitude:(double)geoLong Latitude:(double)geoLat Date:(NSDate *)date Timezone:(int)timezone Elevation:(double)elevation;
+ (long double)rad:(long double)degrees;
+ (int) getDeltaT;
+ (NSString *) timeString:(double)hours;
@end
