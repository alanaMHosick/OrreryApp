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
@class UserLocation;
@interface PlanetRiseViewController : UIViewController <UITextFieldDelegate,


CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property Planet *planet;
@property Planet *earth;
@property Planet *star;
@property UserLocation *userLocation;

@property  (strong, atomic) UITextField *lat;
@property  (strong, atomic) UITextField *lon;

@property  (strong, atomic) UITextField *tz;

@property  (strong, atomic) UITextField *ele;
@property  UISwitch *dst;

@property long double latitude;
@property long double longitude;
@property BOOL daylightSavings;
@property NSDate *date;
@property (strong, nonatomic)Sun *sun;

@property UIActivityIndicatorView *spinner;








@end
