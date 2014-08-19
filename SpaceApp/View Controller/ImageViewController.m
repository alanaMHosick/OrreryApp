//
//  ImageViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"%@",NSLocalizedString(self.name,nil)];
                                                                             
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.bounds;

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:self.background]];
	
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(rect.size.width,rect.size.height);

    
    int labelHeight = 20;
    UILabel *imageCredit =[[UILabel alloc] initWithFrame:CGRectMake(5, rect.size.height - 200, rect.size.width-5, labelHeight)];
    imageCredit.backgroundColor = [UIColor clearColor];
    imageCredit.font = [UIFont fontWithName:@"Verdana" size:15];
    imageCredit.textColor = [UIColor whiteColor];
    imageCredit.textAlignment = NSTextAlignmentCenter;
    imageCredit.lineBreakMode = NSLineBreakByCharWrapping;
    imageCredit.text = [NSString stringWithFormat:NSLocalizedString(@"Image Credit:",nil)];
    [self.scrollView addSubview:imageCredit];
    
    
    labelHeight = 70;
    UILabel *credit =[[UILabel alloc] initWithFrame:CGRectMake(5, rect.size.height - 180, rect.size.width-5, labelHeight)];
    credit.backgroundColor = [UIColor clearColor];
    credit.font = [UIFont fontWithName:@"Verdana" size:15];
    credit.textColor = [UIColor whiteColor];
    credit.textAlignment = NSTextAlignmentCenter;
    credit.numberOfLines = 5;
    credit.lineBreakMode = NSLineBreakByCharWrapping;
    credit.numberOfLines = 3;
    credit.text = self.credit;
    [self.scrollView addSubview:credit];

    [self.view addSubview:self.scrollView];
    
    
    UILabel *gradient1 = [[UILabel alloc] initWithFrame:CGRectMake(3,0,1,rect.size.height)];
    gradient1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:gradient1];
    
    UILabel *gradient2 = [[UILabel alloc] initWithFrame:CGRectMake(0,rect.size.height - 53,rect.size.width,1)];
    gradient2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:gradient2];

    UILabel *gradient3 = [[UILabel alloc] initWithFrame:CGRectMake(0,rect.size.height - 52,rect.size.width,4)];
    gradient3.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:gradient3];
    
    UILabel *gradient4 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,3,rect.size.height)];
    gradient4.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:gradient4];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
