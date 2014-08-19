//
//  ViewerViewController.h
//  Space
//
//  Created by Alana Hosick on 1/28/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Planet;
@class SolarSystem;
@interface ViewerViewController : UIViewController
@property (strong, nonatomic)NSDate *date;

@property Planet *star;
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

@property SolarSystem *solarsystem;

@property UIActivityIndicatorView *spinner;

- (void) viewPlanet:(Planet *)planet;


@end
