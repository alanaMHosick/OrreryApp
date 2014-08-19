//
//  riseSetStrings.h
//  Space
//
//  Created by Alana Hosick on 2/3/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Planet;
@interface RiseSetStrings : NSObject

+ (NSString *)riseTense:(NSDate *)date;
+ (NSString *)setTense:(NSDate *)date;
+ (NSString *)reachTense:(NSDate *)date;
+ (NSString *)takeTense:(NSDate *)date;
+ (NSString *)timeOfDay:(NSString *)hour;
+ (NSString *)And;

+ (NSString *)fullStringRise:(NSString *)rise Set:(NSString *)set Date:(NSDate *)date Planet:(Planet *)planet;

@end
