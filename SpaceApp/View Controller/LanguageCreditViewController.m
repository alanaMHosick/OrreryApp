//
//  LanguageCreditViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "LanguageCreditViewController.h"

@interface LanguageCreditViewController ()

@end

@implementation LanguageCreditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Language Credits", @"Localizable", [NSBundle mainBundle], @"Image Credits", @"this is a comment");
        //self.tabBarItem.image = [UIImage imageNamed:@"Wall-E-icon"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hubbleTerzanStarfield.jpg"]];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"starrySky3.jpg"]];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320,2000);
    
    
    [self fillHomeView];
}




- (void) fillHomeView

{
    CGRect rect = [self.view bounds];
    int width = rect.size.width;
    
    //int titleFontSize = 30;
    int fontSize = 15;
    int leftMargin = 10;
    int rightMargin = 10;
    int labelHeight = 58;
    int y = 20;
    int spacer = 20;
    
    
    
    //NSString *locale = [[NSLocale currentLocale] localeIdentifier];


    
    UILabel *Belal =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[Belal sizeToFit];
    Belal.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    Belal.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    Belal.numberOfLines = 4;
    Belal.lineBreakMode = NSLineBreakByCharWrapping;
    Belal.text = [NSString stringWithFormat:NSLocalizedString(@"The Arabic translation in the Arabic version was done by Belal Mansour.",nil)];
    [self.scrollView addSubview:Belal];
    
    y = y + labelHeight + spacer;
    
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
