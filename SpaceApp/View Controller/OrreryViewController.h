//
//  OrreryViewController.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/16/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Planet;
@class SolarSystem;
@interface OrreryViewController : UIViewController
@property (strong, nonatomic)NSDate *date;

@property SolarSystem *solarsystem;

@property Planet *sun;


@property Planet *mercury;
@property Planet *venus;
@property Planet *earth;
@property Planet *mars;
@property Planet *jupiter;
@property Planet *saturn;
@property Planet *uranus;
@property Planet *neptune;

@property UIActivityIndicatorView *spinner;




@end
