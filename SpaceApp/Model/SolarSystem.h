//
//  SolarSystem.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Planet;
@interface SolarSystem : NSObject


@property Planet *sun;
@property Planet *mercury;
@property Planet *venus;
@property Planet *earth;
@property Planet *moon;
@property Planet *mars;
@property Planet *jupiter;
@property Planet *saturn;
@property Planet *uranus;
@property Planet *neptune;
@property Planet *pluto;

- (id)initSolarSystemFor:(NSDate *)date;

@end
