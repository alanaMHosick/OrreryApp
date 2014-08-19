//
//  Screen.h
//  Space
//
//  Created by Alana Hosick on 1/30/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Screen : NSObject

+ (NSArray *)ViewerBackgroundImages;

+ (int)fitY:(int)y View:(UIView *)view;
+ (int)fitX:(int)x View:(UIView *)view;

+ (int)fitOrreryX:(int)x View:(UIView *)view;
+ (int)fitOrreryY:(int)y View:(UIView *)view;

+(double)radialMultiplierView:(UIView *)view;
+(double)xCuriosityMultiplierView:(UIView *)view;
+(double)yCuriosityMultiplierView:(UIView *)view;

+ (int)sizePlanetButton:(int)size View:(UIView *)view;

+ (int)sizeBackground:(UIView *)view;
+ (int)sizeFont:(int)font View:(UIView *)view;

///////////// curiosity //////////////////////

+ (CGRect ) solLabelView:(UIView *)view;
+ (CGRect ) atmosphereStringLabel1:(UIView *)view;
+ (CGRect ) atmosphereStringLabel2:(UIView *)view;
+ (CGRect ) atmosphereLabel:(UIView *)view;
+ (CGRect ) lowTempLabel:(UIView *)view;
+ (CGRect ) highTempLabel:(UIView *)view;
+ (CGRect ) pressureLabel:(UIView *)view;
+ (CGRect ) dateLabel:(UIView *)view;


@end
