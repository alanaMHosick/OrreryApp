//
//  InfoViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "InfoViewController.h"
#import "CreditsViewController.h"
#import "LanguageCreditViewController.h"
#import "DataCreditViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedStringWithDefaultValue(@"Info", @"Localizable", [NSBundle mainBundle], @"Info", nil);
        self.tabBarItem.image = [UIImage imageNamed:@"sun32"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hubbleTerzanStarfield.jpg"]];
    
    CGRect rect = [self.view bounds];
    int y;
    //int dstLabelHeight = 50;
    int spacer;
    int labelHeight;
    int font;
    int rightMargin;
    int leftMargin;
    int catalystY;
    if (rect.size.height > 1000){
        y = 150;
        spacer = 80;
        labelHeight = 80;
        font = 45;
        leftMargin = 50;
        rightMargin = 100;
        catalystY = 885;
    }
    else if (rect.size.height > 560){
        y = 100;
        spacer = 45;
        labelHeight = 40;
        font = 20;
        leftMargin = 20;
        rightMargin = 40;
        catalystY = 470;
        
        
        
    }else{
        y = 90;
        spacer = 60;
        labelHeight = 35;
        font = 20;
        leftMargin = 20;
        rightMargin = 40;
        catalystY = 390;
    }
    UIColor *buttonColor = [UIColor clearColor];
    
    
    UIButton *imageCredits = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    imageCredits.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    
    imageCredits.backgroundColor = buttonColor;
    imageCredits.titleLabel.font = [UIFont fontWithName:@"Verdana" size:font];
    [imageCredits setTitle:NSLocalizedString(@"Image Credits", nil) forState:UIControlStateNormal];
    [self.view addSubview:imageCredits];
    [imageCredits addTarget:self action:@selector(imageCredits)forControlEvents:UIControlEventTouchUpInside];
    
    y = y +spacer;
    
    UIButton *dataCredits = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dataCredits.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    
    dataCredits.backgroundColor = buttonColor;
    dataCredits.titleLabel.font = [UIFont fontWithName:@"Verdana" size:font];
    [dataCredits setTitle:NSLocalizedString(@"Data Credits", nil) forState:UIControlStateNormal];
    [self.view addSubview:dataCredits];
    [dataCredits addTarget:self action:@selector(dataCredits)forControlEvents:UIControlEventTouchUpInside];
    
    y = y +spacer;
    
    UIButton *languageCredits = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    languageCredits.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    
    languageCredits.backgroundColor =  buttonColor;
    languageCredits.titleLabel.font = [UIFont fontWithName:@"Verdana" size:font];
    [languageCredits setTitle:NSLocalizedString(@"Language Credits", nil) forState:UIControlStateNormal];
    [self.view addSubview:languageCredits];
    [languageCredits addTarget:self action:@selector(languageCredits)forControlEvents:UIControlEventTouchUpInside];
    
    y = y +spacer;
    
    
    UIButton *catalyst = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    catalyst.frame = CGRectMake(leftMargin,catalystY,rect.size.width - rightMargin,labelHeight);
    
    catalyst.backgroundColor =  buttonColor;
    catalyst.titleLabel.font = [UIFont fontWithName:@"Verdana" size:font];
    [catalyst setTitle:NSLocalizedString(@"© Catalyst It Services, Inc", nil) forState:UIControlStateNormal];
    [self.view addSubview:catalyst];

    
}

-(void) imageCredits
{
    CreditsViewController *creditVC = [[CreditsViewController alloc] init];
    [self.navigationController pushViewController:creditVC animated:YES];

}
-(void) dataCredits
{
    DataCreditViewController *dataVC = [[DataCreditViewController alloc] init];
    [self.navigationController pushViewController:dataVC animated:YES];
    
}
-(void) languageCredits
{
    LanguageCreditViewController *languageVC = [[LanguageCreditViewController alloc] init];
    [self.navigationController pushViewController:languageVC animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
