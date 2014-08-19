//
//  RiseSetStrings.m
//  Space
//
//  Created by Alana Hosick on 2/3/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "RiseSetStrings.h"
#import "Planet.h"

@implementation RiseSetStrings

+ (NSString *)riseTense:(NSDate *)date
{
    NSDate *currentDate = [NSDate date];
    if (date > currentDate){
        return NSLocalizedString(@"will rise",nil);
    }else if (date == currentDate)
        return NSLocalizedString(@"rises",nil);
    else{
        return NSLocalizedString(@"rose",nil);
    }
}

+ (NSString *)setTense:(NSDate *)date
{
    NSDate *currentDate = [NSDate date];
    if (date > currentDate){
        return NSLocalizedString(@"will set",nil);
    }else if (date == currentDate)
        return NSLocalizedString(@"sets",nil);
    else{
        return NSLocalizedString(@"set",nil);
    }
}

+ (NSString *)reachTense:(NSDate *)date
{
    NSDate *currentDate = [NSDate date];
    if (date > currentDate){
        return NSLocalizedString(@"will reach",nil);
    }else if (date == currentDate)
        return NSLocalizedString(@"reaches",nil);
    else{
        return NSLocalizedString(@"reached",nil);
    }
}
+ (NSString *)takeTense:(NSDate *)date
{
    NSDate *currentDate = [NSDate date];
    if (date > currentDate){
        return NSLocalizedString(@"will take the same path across the sky as the sun", nil);
    }else if (date == currentDate)
        return NSLocalizedString(@"takes the same path across the sky as the sun", nil);
    else{
        return NSLocalizedString(@"took the same path across the sky as the sun", nil);
    }
}

+ (NSString *)And
{
    return NSLocalizedString(@"and", nil);
}


+ (NSString *)timeOfDay:(NSString *)hour
{
    int h = [hour integerValue];
    if (h >= 3 && h < 8){
        return NSLocalizedString(@"in the early morning",nil);
    }else if (h >= 8 && h < 12){
        return NSLocalizedString(@"in the morning",nil);
    }else if (h >= 12 && h < 17){
        return NSLocalizedString(@"in the afternoon",nil);
    }else if (h >= 17 && h < 22){
        return NSLocalizedString(@"in the evening",nil);
    }else{
        return NSLocalizedString(@"in the middle of the night",nil);
    }
    
    
}

+ (NSString *)fullStringRise:(NSString *)rise Set:(NSString *)set Date:(NSDate *)date Planet:(Planet *)planet
{
    //Rise
    int r = [rise integerValue];
    int s = [set integerValue];
    NSDate *currentDate = [NSDate date];
    
    NSString *returnString = @"no location data is available for that body at this time";
    if (r >= 3 && r < 8){ //rises in the early morning
        
        if(s >= 12 && s < 17){
           
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the early morning and will set in the afternoon",nil),[NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the early morning and sets in the afternoon",nil),[NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the early morning and set in the afternoon",nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        }if(s >= 17 && s < 22){
            
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the early morning and will set in the evening",nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the early morning and sets in the evening",nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the early morning and set in the evening", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        }
        
    }else if (r >= 8 && r < 12){ //rises in the morning
        
        if(s >= 17 && s < 22){
            
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the morning and will set in the evening", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the morning and sets in the evening", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];
            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the morning and set in the evening", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        }
    
    }else if (r >= 12 && r < 17){ //rises in the afternoon
    
        if(s >= 3 && s < 8){
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the afternoon and will set in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the afternoon and sets in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the afternoon and set in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        
        }else if(s >=22 || s < 3){
            
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the afternoon and will set in the middle of the night", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];
            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the afternoon and sets in the middle of the night", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the afternoon and set in the middle of the night", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        }
    }else if (r >= 17 && r < 22){ // rises in the evening
        
        if(s >= 3 && s < 8){
        
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the evening and will set in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the evening and sets in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the evening and set in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        }
    }else{ // rises in the middle of the night
        
        if(s >= 3 && s < 8){
            
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the middle of the night and will set in the early morning", nil),[NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];
            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the middle of the night and sets in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the middle of the night and set in the early morning", nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }
        }
        if(s >= 8 && s < 12){
            if(date > currentDate){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ will rise in the middle of the night and will set in the morning",nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];
            }else if ([date isEqualToDate:currentDate]){
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rises in the middle of the night and sets in the morning",nil), [NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];

            }else{
                return [NSString stringWithFormat:NSLocalizedString(@"%@ rose in the middle of the night and set in the morning",nil),[NSString stringWithFormat:NSLocalizedString(planet.name, nil)]];
            }
        }
        
    }
    return NSLocalizedString(returnString, nil);
}

@end
