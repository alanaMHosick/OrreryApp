//
//  CuriosityViewController.h
//  Space
//
//  Created by Alana Hosick on 1/25/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Home;

@interface CuriosityViewController : UIViewController

@property (strong, nonatomic)Home *home;
@property (strong, nonatomic) UILabel *dateLabel;

@property UIActivityIndicatorView *spinner;

- (void) fillHomeView;

@end
