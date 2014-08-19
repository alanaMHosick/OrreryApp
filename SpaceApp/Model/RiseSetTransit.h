//
//  RiseSetTransit.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/16/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Planet;
@interface RiseSetTransit : NSObject

@property double geoLong; //geographic longitude of the observer in degrees, measured positiely wet from Greenwich, negitively to the east.
@property double geoLat; //geographic latitude of the observer, positive in the northern hemisphere, negitive in the southern hemisphere.
@property double deltaT; //the difference DT - UT between Dynamical Time and Universal Time in seconds of time.  (Approx 68s now)
@property double h0; // standard altitude, h0 = -.5667 for stars and planets, h0 = -.8333 for the sun.  for the moon it is not constant.  Can be estimated to be h0 = .125 but will not be entirely accurate.
@property double apparentSideralTime; // time at zeroH Univertsal time on day D for the meridian of Greenwich in degrees.  
@property double julianDay; //begins at greenwich mean noon








////////////////
+ (double) rightAccention:(Planet *)planet Sun:(Planet *)sun Date:(NSDate *)date;
+ (double) declination:(Planet *)planet Sun:(Planet *)sun Date:(NSDate *)date;
+ (double) getApparentSideralTime;
+ (void) go;

////////////////
@end
