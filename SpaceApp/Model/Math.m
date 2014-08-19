//
//  Math.m
//  Space
//
//  Created by Alana Hosick on 1/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Math.h"
#import "Planet.h"
#import "Sun.h"
#import "SettingsViewController.h"

@implementation Math

+ (NSString *)calculateDistanceX1:(double)x1 Y1:(double)y1 Z1:(double)z1 X2:(double)x2 Y2:(double)y2 Z2:(double)z2
{
    
    
    double distance =  sqrt(pow((x1 - x2),2) +pow((y1 - y2),2)+pow((z1 - z2),2) );
    //int intDistance = (int)distance;
   
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:0];
    [formatter setGroupingSeparator:[[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator]];
    NSString *distanceString = [formatter stringFromNumber:[NSNumber numberWithDouble:distance]];
    
    
    return distanceString;

}

+ (double)calculateAngleX:(double)x Y:(double)y
{
    double angle = 0;
    int quadrant =0 ;
    
    double distanceFromOrigin = sqrt(pow((x),2) +pow((y),2));
    
    if(x > 0 && y > 0){
        quadrant = 1;
        double angle = asin(y/ distanceFromOrigin) - (2*(asin(y/ distanceFromOrigin)));
        //double degrees = angle * 57.3;
        //NSLog  (@" angle = %f degrees = %f", angle, degrees);
        return angle;
    }else if (x < 0 && y > 0){
        quadrant = 2;
        double angle = (asin(y/ distanceFromOrigin) + 3.14);
        //double degrees = angle * 57.3;
        //NSLog  (@" angle = %f degrees = %f", angle, degrees);
        return angle;
    }else if (x < 0 && y < 0){
        quadrant = 3;
        double angle = (asin(y/ distanceFromOrigin) + (3.14));
        //double degrees = angle * 57.3;
       // NSLog  (@" angle = %f degrees = %f", angle, degrees);
        return angle;
    }else{
        quadrant = 4;
        double angle = asin(y/ distanceFromOrigin) - (2*(asin(y/ distanceFromOrigin)));
        //double degrees = angle * 57.3;
       // NSLog  (@" angle = %f degrees = %f", angle, degrees);
        return angle;

    }
    
    return angle;
}

+ (NSString *)getCurrentDate
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    return dateString;
}

+ (NSString *)formatDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getDay:(NSDate *)date
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getMonth:(NSDate *)date
{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}


+(Planet *)findZenithPlanet:(Planet *)p Earth:(Planet *)earth Sun:(Planet *)star
{
    NSArray *planets = @[star, p,];
    
    //Get earth centered coordinates and quadrant
    for(Planet *p in planets){
        
        p.earthCenteredX = p.x - earth.x;
        p.earthCenteredY = p.y - earth.y;
        p.earthCenteredZ = p.z - earth.z;
        
        //NSLog(@"   ===  Earth centered x of %@ is: %f", p.name, p.earthCenteredX);
        
        if(p.earthCenteredX > 0 && p.earthCenteredY > 0){
            p.earthCenteredQuadrant = 1;
            p.polarAngle = atan(p.earthCenteredY/p.earthCenteredX);
            //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
            
        }else if (p.earthCenteredX < 0 && p.earthCenteredY > 0){
            p.earthCenteredQuadrant = 2;
            p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + 3.141593);
            //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
            
        }else if (p.earthCenteredX < 0 && p.earthCenteredY < 0){
            p.earthCenteredQuadrant = 3;
            p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + 3.141593);
            //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
            
        }else{
            p.earthCenteredQuadrant = 4;
            p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + (2*3.141593));
            //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
            
        }
        NSLog(@"   000  The polar coordinate of %@ is: %f", star.name, star.polarAngle);
    }
    //rotate coordinates to put the sun at zero
    for(Planet *p in planets){
        
        if(p.polarAngle < star.polarAngle){
            double difference = star.polarAngle - p.polarAngle;
            p.polarAngle = 2 * (3.141593) - difference;
        }
        else if (p.polarAngle > star.polarAngle){
            p.polarAngle = p.polarAngle - star.polarAngle;
            NSLog(@"   000  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
        }        
    }
   
    star.polarAngle = 0;
    
    //print angle
    for(Planet *p in planets){
        NSLog(@"The twisted polar radians of %@ is: %f", p.name, p.polarAngle);
        p.polarRadians = p.polarAngle;
        //NSLog(@"The twisted polar coordinate of %@ is: %f", p.name, (p.polarAngle * 57));
        //NSLog(@"The time %@ is: %f", p.name, (((p.polarAngle * 57)/360)*24));
    }
    double tempPlanetAngle = (((p.polarAngle * 57)/360)*24);
    double planetAngle;
    if (tempPlanetAngle < 12){
        planetAngle = tempPlanetAngle + 12;
    }else{
        planetAngle = tempPlanetAngle - 12;
    
    }
    p.zenith = planetAngle;
    return p;
}



+(double)findPolarAnglePlanet:(Planet *)p Earth:(Planet *)earth Sun:(Planet *)star
{
        NSArray *planets = @[star, p,];
        
        //Get earth centered coordinates and quadrant
        for(Planet *p in planets){
            
            p.earthCenteredX = p.x - earth.x;
            p.earthCenteredY = p.y - earth.y;
            p.earthCenteredZ = p.z - earth.z;
            
            //NSLog(@"   ===  Earth centered x of %@ is: %f", p.name, p.earthCenteredX);
            
            if(p.earthCenteredX > 0 && p.earthCenteredY > 0){
                p.earthCenteredQuadrant = 1;
                p.polarAngle = atan(p.earthCenteredY/p.earthCenteredX);
                //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
                
            }else if (p.earthCenteredX < 0 && p.earthCenteredY > 0){
                p.earthCenteredQuadrant = 2;
                p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + 3.141593);
                //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
                
            }else if (p.earthCenteredX < 0 && p.earthCenteredY < 0){
                p.earthCenteredQuadrant = 3;
                p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + 3.141593);
                //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
                
            }else{
                p.earthCenteredQuadrant = 4;
                p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + (2*3.141593));
                //NSLog(@"   ===  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
                
            }
            //NSLog(@"   000  The polar coordinate of %@ is: %f", star.name, star.polarAngle);
        }
        //rotate coordinates to put the sun at zero
        for(Planet *p in planets){
            
            if(p.polarAngle < star.polarAngle){
                double difference = star.polarAngle - p.polarAngle;
                p.polarAngle = 2 * (3.141593) - difference;
            }
            else if (p.polarAngle > star.polarAngle){
                p.polarAngle = p.polarAngle - star.polarAngle;
                //NSLog(@"   000  The polar coordinate of %@ is: %f", p.name, p.polarAngle);
            }        
        }
        
        star.polarAngle = 0;
    //NSLog(@" PPPPPPPPPPP polar Angle: %f", p.polarAngle);
    return p.polarAngle;
}

+ (double)hoursMinutesSecondsToSeconds:(long)seconds Minutes:(long)minutes Hours:(long)hours
{
    return (hours * 3600) * (minutes * 60) + seconds;
}
+ (NSArray *)timeFromSeconds:(long)numberOfSeconds
{
    int hours = (int)numberOfSeconds / 3600;
    NSNumber *h = [NSNumber numberWithInt:hours];
    long remainder = numberOfSeconds % 3600;
    int minutes = (int)remainder / 60;
    NSNumber *m = [NSNumber numberWithInt:minutes];
    remainder = minutes % 3600;
    int seconds = (int)remainder;
    NSNumber *s = [NSNumber numberWithInt:seconds];
    

    
    NSArray *time = @[h, m, s];
    
    return time;
}

+ (double) riseSecondsPlanet:(Planet *)planet Sunrise:(double)sunrise
{
    double seconds = ((planet.polarAngle * 86400) / 2) / 3.141592654;
    seconds = seconds + sunrise;
    if(seconds > 86400){
        seconds = seconds - 86400;
    }
    return seconds;
}

+ (double) setSecondsPlanet:(Planet *)planet Sunset:(double)sunset
{
    double seconds = ((planet.polarAngle * 86400) / 2) / 3.141592654;
    seconds = seconds + sunset;
    if(seconds > 86400){
        seconds = seconds - 86400;
    }
    return seconds;
}

+ (NSString *) userTemp:(NSString *)temp
{
    double doubleTemp = [temp doubleValue];
    if ([temperatureUnits isEqualToString:(@"fahrenheit")]){
        return [NSString stringWithFormat:@"%.0lf", ((doubleTemp * 9 /5) + 32)];
    }else if ([temperatureUnits isEqualToString:(@"kelvin")]){
        return [NSString stringWithFormat:@"%.0lf", (doubleTemp + 273)];
    }else{
        return temp;
    }
}

+ (NSString *) userDistance:(NSString *)distance
{
    distance = [distance stringByReplacingOccurrencesOfString:@"," withString:@""];
    double doubleDistance = [distance doubleValue];
    if ([distanceUnits isEqualToString:(@"miles")]){
        double temp = doubleDistance * .621371;
        doubleDistance = temp;
    }else if ([distanceUnits isEqualToString:(@"light minutes")]){
        doubleDistance = doubleDistance *.0000000555940159;
    }
    if([distanceUnits isEqualToString:@"light minutes"]){
        return [NSString stringWithFormat:@"%.2lf", doubleDistance];
    }
    else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setGroupingSize:3];
        [numberFormatter setGroupingSeparator:@","];
        [numberFormatter setUsesGroupingSeparator:YES];
        NSNumber *num = [NSNumber numberWithDouble:doubleDistance];
        NSString *commaString = [numberFormatter stringFromNumber:num];
        return commaString;
    }
}

@end
