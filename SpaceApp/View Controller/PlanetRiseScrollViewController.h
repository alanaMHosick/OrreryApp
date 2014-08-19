//
//  PlanetRiseScrollViewController.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/22/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class Planet;
@class Sun;
@class UserLocation;
//@class UserLocation;
@interface PlanetRiseScrollViewController : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    
   // UITextField *pickerTextField;
    UIPickerView *pickerView;
    NSArray *pickerArray;
}

//CLLocationManagerDelegate>{
//    CLLocationManager *locationManager;
//}



@property (strong, nonatomic) UIScrollView *scrollView;

//UIPickerView *pickerView;
//@property NSArray *pickerArray;
//@property UITextField *pickerTextField;

@property Planet *planet;
@property Planet *earth;
@property Planet *star;
@property UserLocation *userLocation;

@property  (strong, atomic) UITextField *lat;
@property  (strong, atomic) UITextField *lon;
@property  (strong, atomic) UITextField *tz;
@property  (strong, atomic) UITextField *tz2;
@property  (strong, atomic) UITextField *ele;
@property  UISwitch *dst;

@property long double latitude;
@property long double longitude;
@property BOOL daylightSavings;
@property NSDate *date;
@property int timezone;
@property int elevation;
@property (strong, nonatomic)Sun *sun;

@property NSString *distance;

@property UIButton *timezoneButton;

@property UIActivityIndicatorView *spinner;







@end
