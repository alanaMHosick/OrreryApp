//
//  SettingsViewController.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/14/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
extern NSString *distanceUnits;
extern NSString *temperatureUnits;
extern NSString *distanceAbrev;
extern NSString *temperatureAbrev;

@property int y;
@property int dstLabelHeight;
@property int spacer;
@property int labelHeight;
@property int font;
@property int rightMargin;
@property int leftMargin;
@property int buttonXposition;
@property int width;

@property UIButton *radioButton2fahrenheit;
@property UIButton *radioButton2celsius;
@property UIButton *radioButton2kelvin;
@property UIButton *radioButton1kilometers;
@property UIButton *radioButton1miles;
@property UIButton *radioButton1lightminutes;

@end
