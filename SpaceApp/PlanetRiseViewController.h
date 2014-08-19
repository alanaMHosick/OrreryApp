//
//  PlanetRiseViewController.h
//  Space
//
//  Created by Alana Hosick on 2/2/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class Planet;
@class Sun;
@interface PlanetRiseViewController : UIViewController


<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property Planet *planet;
@property Planet *earth;
@property Planet *star;

@property  UITextView *lat;
@property  UITextView *lon;
@property UISwitch *dst;

@property long double latitude;
@property long double longitude;
@property BOOL daylightSavings;
@property NSDate *date;
@property (strong, nonatomic)Sun *sun;




@end
