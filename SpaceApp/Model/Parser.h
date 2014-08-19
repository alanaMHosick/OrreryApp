//
//  Parser.h
//  Space
//
//  Created by Alana Hosick on 1/28/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

+ (NSString *)getValueForKey:(NSString *)key inString:(NSString *)xmlString;
+ (double)getSecondsFromStringForKey:(NSString *)event inString:(NSString *)xmlString;
+ (NSString *)getTextBetweenFirst:(NSString *)first Second:(NSString *)second inString:(NSString *)string;

@end
