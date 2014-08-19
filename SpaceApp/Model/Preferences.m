//
//  Preferences.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/13/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Preferences.h"


@implementation Preferences


static Preferences* _sharedMySingleton = nil;

+(Preferences*)sharedMySingleton
{
    @synchronized([Preferences class])
    {
        if (!_sharedMySingleton)
           // [[self alloc] init];
        
        return _sharedMySingleton;
    }
    
    return nil;
}

typedef enum Distance
{
    lightYears,
    miles,
    kilometers
} Distance;

typedef enum Temperature
{
    C,
    F,
    K
} Temperature;

@end
