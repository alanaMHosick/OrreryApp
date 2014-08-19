//
//  UserLocation.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/21/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocation : NSObject

@property NSString *timeStamp;
@property double longitude;
@property double latitude;

extern double userElevation;
extern int userTimezone;
extern BOOL dstBool;
extern NSDate *userDate;
extern NSString *timezoneName;

- (id)initUserLongitude:(double)longitude Latitude:(double)latitude;
@end
