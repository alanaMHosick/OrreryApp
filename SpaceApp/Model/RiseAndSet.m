//
//  RiseAndSet.m
//  Space
//
//  Created by Alana Hosick on 2/1/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "RiseAndSet.h"

@implementation RiseAndSet
/*
Source:
Almanac for Computers, 1990
published by Nautical Almanac Office
United States Naval Observatory
Washington, DC 20392

Inputs:
day, month, year:      date of sunrise/sunset
latitude, longitude:   location for sunrise/sunset
zenith:                Sun's zenith for sunrise/sunset
offical      = 90 degrees 50'
civil        = 96 degrees
nautical     = 102 degrees
astronomical = 108 degrees

NOTE: longitude is positive for East and negative for West
NOTE: the algorithm assumes the use of a calculator with the
trig functions in "degree" (rather than "radian") mode. Most
programming languages assume radian arguments, requiring back
and forth convertions. The factor is 180/pi. So, for instance,
the equation RA = atan(0.91764 * tan(L)) would be coded as RA
= (180/pi)*atan(0.91764 * tan((pi/180)*L)) to give a degree
answer with a degree input for L.
*/
+ (void)getRise
{

//1. first calculate the day of the year

    int month = 9;
    int day = 6;
    int year = 1972;
    
    double longitude = -122.406417;
    //double latitude = 37.785834;


    int N1 = floor((275 * month) / 9);
    int N2 = floor((month + 9) / 12);
    int N3 = (1 + floor((year - 4 * floor(year / 4) + 2) / 3));
    int N = N1 - (N2 * N3) + day - 30;

//2. convert the longitude to hour value and calculate an approximate time

    double lngHour = longitude / 15;

//if rising time is desired:
    double t = N + ((6 - lngHour) / 24);
//if setting time is desired:
    //tSet = N + ((18 - lngHour) / 24)

//3. calculate the Sun's mean anomaly

    double M = (0.9856 * t) - 3.289;

//4. calculate the Sun's true longitude

    double L = M + (1.916 * sin(M)) + (0.020 * sin(2 * M)) + 282.634;
    
    while(L >= 360){
        L = L - 360;
    }
    while(L < 0){
        L = L + 360;
    }
//NOTE: L potentially needs to be adjusted into the range [0,360) by adding/subtracting 360
    
//5a. calculate the Sun's right ascension
    
    double RA = atan((0.91764 * 0.0174532925) * tan(L * 0.0174532925));
    
    while(RA >= 360){
        RA = RA - 360;
    }
    while(RA < 0){
        RA = RA + 360;
    }
//NOTE: RA potentially needs to be adjusted into the range [0,360) by adding/subtracting 360
    
//5b. right ascension value needs to be in the same quadrant as L
//                                                                                                                   
    int Lquadrant  = (floor( L/90)) * 90;
    int RAquadrant = (floor(RA/90)) * 90;
    RA = RA + (Lquadrant - RAquadrant);
    
//5c. right ascension value needs to be converted into hours
//                                                                                                                   
    RA = RA / 15;
//                                                                                                                   
//6. calculate the Sun's declination
//                                                                                                                   
    //double sinDec = 0.39782 * sin(L* 0.0174532925);
    //double cosDec = cos(asin(sinDec* 0.0174532925)* 0.0174532925);
    
//7a. calculate the Sun's local hour angle
    
    //double cosH = (cos(zenith) - (sinDec * sin(latitude))) / (cosDec * cos(latitude))
//                                                                                                                   
//                                                                                                                   if (cosH >  1) 
//                                                                                                                   the sun never rises on this location (on the specified date)
//                                                                                                                   if (cosH < -1)
//                                                                                                                   the sun never sets on this location (on the specified date)
//                                                                                                                   
//                                                                                                                   7b. finish calculating H and convert into hours
//                                                                                                                   
//                                                                                                                   if if rising time is desired:
//                                                                                                                   H = 360 - acos(cosH)
//                                                                                                                   if setting time is desired:
//                                                                                                                   H = acos(cosH)
//                                                                                                                   
//                                                                                                                   H = H / 15
//                                                                                                                   
//                                                                                                                   8. calculate local mean time of rising/setting
//                                                                                                                   
//                                                                                                                   T = H + RA - (0.06571 * t) - 6.622
//                                                                                                                   
//                                                                                                                   9. adjust back to UTC
//                                                                                                                   
//                                                                                                                   UT = T - lngHour
//                                                                                                                   NOTE: UT potentially needs to be adjusted into the range [0,24) by adding/subtracting 24
//                                                                                                                                                                             
//                                                                                                                                                                             10. convert UT value to local time zone of latitude/longitude
//                                                                                                                                                                             
//                                                                                                                                                                             localT = UT + localOffset
//
//
}
@end
