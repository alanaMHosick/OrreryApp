//
//  ImageViewController.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property NSString *background;
@property NSString *credit;
@property NSString *name;

@property (strong, nonatomic) UIScrollView *scrollView;

@end
