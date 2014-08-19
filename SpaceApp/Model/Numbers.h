//
//  Numbers.h
//  SpaceApp
//
//  Created by Alana Hosick on 3/1/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Numbers : NSObject

+(NSString *) formatStr:(NSString *)number Digits:(int)digits Decimals:(int)decimals;
+(NSString *) formatDouble:(double)number Digits:(int)digits;
+(NSString *) formatDate:(NSString *)date;
+(NSString *) formatTime:(NSString *)time;

@end
