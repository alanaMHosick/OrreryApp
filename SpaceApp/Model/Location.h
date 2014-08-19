//
//  Location.h
//  Space
//
//  Created by Alana Hosick on 1/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
// xyz coord
@property long double xMercury;
@property long double yMercury;
@property long double zMercury;

@property long double xVenus;
@property long double yVenus;
@property long double zVenus;

@property long double xEarth;
@property long double yEarth;
@property long double zEarth;

@property long double xMars;
@property long double yMars;
@property long double zMars;

@property long double xJupiter;
@property long double yJupiter;
@property long double zJupiter;

@property long double xSaturn;
@property long double ySaturn;
@property long double zSaturn;

@property long double xUranus;
@property long double yUranus;
@property long double zUranus;

@property long double xNeptune;
@property long double yNeptune;
@property long double zNeptune;

// xyz velocity
@property long double xVMars;
@property long double yVMars;
@property long double zVMars;

@end
