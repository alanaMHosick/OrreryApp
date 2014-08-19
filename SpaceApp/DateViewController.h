//
//  DateViewController.h
//  Space
//
//  Created by Alana Hosick on 1/25/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Planet;
@interface DateViewController : UIViewController

@property (strong, nonatomic)NSDate *date;

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
