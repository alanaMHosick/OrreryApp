//
//  Planet.h
//  Space
//
//  Created by Alana Hosick on 1/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Planet : NSObject

@property (strong, nonatomic) NSString *name;
@property double x;
@property double y;
@property double z;
@property int graphDistance;

@property double earthCenteredX;
@property double earthCenteredY;
@property double earthCenteredZ;

@property double rise;
@property double zenith;
@property double set;

@property double polarRadians;
@property double polarAngle;

@property int earthCenteredQuadrant;

@property double RA;
@property double DEC;
@property NSString *riseTime;
@property NSString *transitTime;
@property NSString *setTime;
@property NSString  *distance;


- (id)initPlanet:(NSString *)name Date:(NSDate *)date;
- (id)init;

@end
