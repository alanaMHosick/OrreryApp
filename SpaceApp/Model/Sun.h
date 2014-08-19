//
//  Sun.h
//  Space
//
//  Created by Alana Hosick on 1/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sun : NSObject

@property NSString *sunrise;
@property NSString *sunset;
@property long double longitude;
@property long double latitude;
@property BOOL dst;
@property NSString *responseString;

- (id)initSunLat:(long double)latitude Long:(long double)longitude Date:(NSDate *)date DST:(BOOL)dst;



@end


