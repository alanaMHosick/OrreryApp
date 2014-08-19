//
//  RiseSetTransit.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/16/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "RiseSetTransit.h"
#import "Planet.h"

@implementation RiseSetTransit

- (int) getDeltaT
{
    return 68;
}
+ (double) getApparentSideralTime
{
    NSLog(@"*********************************");
    NSDate *date = [NSDate date];
    
    // get JD
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"g"];
    int JD = [[dateFormatter stringFromDate:date] integerValue];
    
    NSLog(@" JD: %d", JD);
    
    double T = (JD - 2451545.0)/36525;
    NSLog(@" T: %f", T);
    
    
    
    double apparentSideralTime = (100.46061837 + (36000.770053608 * T) + (.000387933 * (T * T)) - ((T * T * T) / 38710000));
    //self.apparentSideralTime = apparentSideralTime;
    
    
    
    if (apparentSideralTime > 0) {
        while (apparentSideralTime > 360) {
            apparentSideralTime = apparentSideralTime - 360;
        }
    }else if (apparentSideralTime < 0) {
        while (apparentSideralTime < 360) {
            apparentSideralTime = apparentSideralTime + 360;
        }
    }
    
    NSLog(@" apparent sideral time: %f", apparentSideralTime);
    
    NSLog(@"*********************************");
    return 9;
}

+ (double) rightAccention:(Planet *)planet Sun:(Planet *)sun Date:(NSDate *)date
{
    
     NSLog(@"*********************************");
    //Planet *planet = [[Planet alloc] initPlanet:(NSString *)name Date:(NSDate *)date];
    //Planet *sun = [[Planet alloc] initPlanet:(NSString *)@"sun" Date:(NSDate *)date];
    
    double xp = planet.x;// + sun.x;
    double yp = planet.y;// + sun.y;
    //double zp = planet.z;// + sun.z;
    
    double Ra = atan((yp/xp));
    NSLog(@" Ra: %f", Ra);
    NSLog(@" planetx: %f", planet.x);
     Ra = (Ra  * 57.2957795)/15;
    NSLog(@" Ra: %f", Ra);
     NSLog(@"*********************************");
   
    return Ra;
}

+ (double) declination:(Planet *)planet Sun:(Planet *)sun Date:(NSDate *)date
{
    
    NSLog(@"*********************************");
    //Planet *planet = [[Planet alloc] initPlanet:(NSString *)name Date:(NSDate *)date];
    //Planet *sun = [[Planet alloc] initPlanet:(NSString *)@"sun" Date:(NSDate *)date];
    
    double xp = planet.x + sun.x;
    double yp = planet.y + sun.y;
    long double zp = planet.z + sun.z;
    
    double temp = (xp * xp);
    NSLog(@" temp: %f", temp);
    
    
    
    double temp3 = sqrt(yp * yp);
    NSLog(@" temp3: %f", temp3);

    long double temp31 = temp + temp3;
    NSLog(@"temp31: %Lf", temp31);
    
    NSLog(@"  zp: %Lf", zp);
    
    long double temp32 = (long double)zp/temp31;
    NSLog(@"  temp32: %Lf", temp32);
    
    
    long double temp4 = (temp31*1);
    NSLog(@"temp4: %Lf", temp4);
    
    long double div = (float)295688550/6204722942989.5112;
    NSLog(@"  div: %Lf", div);
    
    double dec = atan(zp/((xp * xp)+(sqrt(yp * yp))));
    NSLog(@" dec: %f", dec);
    NSLog(@" planetz: %f", planet.z);
    NSLog(@" planety: %f", planet.y);
    NSLog(@" planetx: %f", planet.x);
    
    NSString *string =[NSString stringWithFormat:@"%.20f", dec];
    NSLog(@" string: %@", string);

    dec = (dec  * 57.2957795);
    NSLog(@" dec: %f", dec);
    
    string =[NSString stringWithFormat:@"%.20f", dec];
    NSLog(@" string: %@", string);
    
    NSLog(@"*********************************");
    
    return dec;
}

+ (void) go
{
    //[self rightAccention:(NSString *)@"jupiter" Date:[NSDate date]];
}

@end
