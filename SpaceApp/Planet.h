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

- (id)initPlanet:(NSString *)name Date:(NSDate *)date;


@end
