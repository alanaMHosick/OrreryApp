//
//  Zones.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/22/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Zones.h"

@implementation Zones

+ (NSString *)zone:(NSString *)offset

{
    NSLog(@" offset: %@", offset);
    NSDictionary *z = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"West Africa", @"-1",
                       @"Azores", @"-2",
                       @"GMT - 3", @"-3",
                       @"Atlantic Standard",  @"-4",
                       @"Eastern Standard", @"-5",
                       @"Central Standard", @"-6",
                       @"Mountain Standard",  @"-7",
                       @"Pacific Standard", @"-8",
                       @"Yukon Standard",@"-9",
                       @"Alaska - Hawaii Standard",@"-10",
                       @"Nome",@"-11",
                       @"International Date Line",@"-12",
                       @"GMT",@"0",
                       @"Central European",@"1",
                       @"Eastern European", @"2",
                       @"GMT + 3", @"3",
                       @"GMT + 4", @"4",
                       @"GMT + 5", @"5",
                       @"GMT + 6", @"6",
                       @"GMT + 7", @"7",
                       @"China Coast",@"8",
                       @"Japan Standard",@"9",
                       @"Guam Standard",@"10",
                       @"GMT + 11",@"11",
                       @"New Zealand Standard", @"12", nil];
    return z[offset];
}


@end
