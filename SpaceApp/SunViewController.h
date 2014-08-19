//
//  SunViewController.h
//  Space
//
//  Created by Alana Hosick on 1/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Sun.h"
@class Sun;
@interface SunViewController : UIViewController

<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}


@property  UITextView *lat;
@property  UITextView *lon;
@property UISwitch *dst;

@property long double latitude;
@property long double longitude;
@property BOOL daylightSavings;
@property NSDate *date;
@property (strong, nonatomic)Sun *sun;



@end
