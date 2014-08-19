//
//  Parser.m
//  Space
//
//  Created by Alana Hosick on 1/28/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Parser.h"



@implementation Parser

+ (NSString *)getValueForKey:(NSString *)key inString:(NSString *)xmlString
{
    NSString *startKey = [NSString stringWithFormat:@"<%@>",key];
    NSString *endKey = [NSString stringWithFormat:@"</%@>",key];
    NSString *temp = [[xmlString componentsSeparatedByString:startKey] lastObject];
    NSString *value = [[temp componentsSeparatedByString:endKey] firstObject];
    NSLog(@"Parser value: %@", value);
    return value;
}

+ (NSString *)getTextBetweenFirst:(NSString *)first Second:(NSString *)second inString:(NSString *)string
{
    NSString *startKey = first;
    NSString *endKey = second;
    
    NSLog(@" JSON string: %@", string);
    
    NSString *temp = [[string componentsSeparatedByString:startKey] lastObject];
    NSLog(@"temp value: %@", temp);
    NSString *value = [[temp componentsSeparatedByString:endKey] firstObject];
    NSLog(@"Parser value: %@", value);
    return value;
}

+ (double)getSecondsFromStringForKey:(NSString *)event inString:(NSString *)xmlString
{
    NSString *time = [Parser getValueForKey:event inString:xmlString];
    NSString *hours = [[time componentsSeparatedByString:@":"] firstObject];
    NSString *temp = [[time componentsSeparatedByString:@":"] lastObject];
    NSString *minutes = [[temp componentsSeparatedByString:@":"] firstObject];
    NSString *seconds = [[time componentsSeparatedByString:@":"] lastObject];
    
    double h = [hours doubleValue];
    double m = [minutes doubleValue];
    double s = [seconds doubleValue];
    double totalSeconds =  (h * 3600) + (m * 60) + (s);
    
    return totalSeconds;
}


@end
