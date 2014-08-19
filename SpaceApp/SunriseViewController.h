//
//  SunriseViewController.h
//  Space
//
//  Created by Alana Hosick on 1/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Math.h"
#import "Sun.h"
@class Sun;
@interface SunriseViewController : UIViewController

@property Sun *sun;
@property long double longitude;
@property long double latitude;
@property BOOL dst;
@property NSDate *date;

@property UIActivityIndicatorView *spinner;


@end
