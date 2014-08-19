//
//  PlanetTimeViewController.h
//  Space
//
//  Created by Alana Hosick on 2/2/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Planet;
@class Sun;
@interface PlanetTimeViewController : UIViewController
@property Planet *planet;
@property Planet *earth;
@property Planet *star;
@property long double longitude;
@property long double latitude;
@property BOOL dst;
@property NSDate *date;
@property Sun *sun;
@property double sunrise;
@property double sunset;
@property NSArray *riseTime;
@property NSArray *setTime;
@property NSArray *zenithTime;



@property UIActivityIndicatorView *spinner;



@end
