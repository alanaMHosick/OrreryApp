//
//  CuriosityViewController.m
//  Space
//
//  Created by Alana Hosick on 1/25/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "CuriosityViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "Home.h"
#import "Screen.h"
#import "Math.h"
#import "SWRevealViewController.h"
#import "SettingsviewController.h"
#import "CreditsViewController.h"
#import "ImageViewController.h"
#import "Numbers.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>

///////////
//#import "RiseSetTransit.h"


@interface CuriosityViewController ()

@end

@implementation CuriosityViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Curiosity page title", @"Localizable", [NSBundle mainBundle], @"Curiosity", @"this is a comment");
        self.tabBarItem.image = [UIImage imageNamed:@"Wall-E-icon"];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
    if(rect.size.height < 600){
        self.background = @"marsLandscapeImageSm.png";
    }else{
        self.background = @"marsLandscapeImage.png";
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:self.background]];
    
    
    
    

    
    UIColor *buttonColor = [UIColor clearColor];
    
    
    UIButton *imageViewer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    imageViewer.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    
    imageViewer .backgroundColor = buttonColor;
    [self.view addSubview:imageViewer ];
    [imageViewer  addTarget:self action:@selector(imageViewer)forControlEvents:UIControlEventTouchUpInside];

    
    Home *home = [[Home alloc] init];
    NSLog(@"%@ ",home);
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings14.png"]
                                                                       
                                                                         style:UIBarButtonItemStyleBordered target:self action:@selector(updateFields)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [self fillHomeView];
}
- (void) updateFields
{
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    [revealController revealToggle:self.view];
    [self fillHomeView];
}

- (void) updateHomeView:(id)object

{
    [[self.view viewWithTag:400] removeFromSuperview];
    [[self.view viewWithTag:401] removeFromSuperview];
    [self fillHomeView];
}

- (void) fillHomeView

{
    [[self.view viewWithTag:400] removeFromSuperview];
    [[self.view viewWithTag:401] removeFromSuperview];

    CGRect rect = self.view.bounds;
   
    
    
    UILabel *solLabel;
    UILabel *atmosphereStringLabel1;
    UILabel *atmosphereStringLabel2;
    UILabel *atmosphereLabel;
    UILabel *pressureLabel;
    UILabel *dateLabel;
    
    if (rect.size.height > 1000){
        solLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70,rect.size.width,40)];
        atmosphereStringLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,190,rect.size.width,70)];
        atmosphereStringLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,250,rect.size.width,70)];
        atmosphereLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,410,rect.size.width,70)];
        self.lowTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,780,rect.size.width,40)];
        self.highTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,820,rect.size.width,40)];
        pressureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,860,rect.size.width,40)];
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,900,rect.size.width,40)];
        
        UIImageView *tempBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tempLabel10" ]];
        [tempBar setFrame:CGRectMake(0,700,rect.size.width,500)];
        [self.view addSubview:tempBar];


    }
    
    else if (rect.size.height > 560){
        
        solLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70,rect.size.width,40)];
        atmosphereStringLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,190,rect.size.width,50)];
        atmosphereStringLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,230,rect.size.width,50)];
        atmosphereLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,280,rect.size.width,80)];
        self.lowTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,432,rect.size.width,20)];
        self.highTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,452,rect.size.width,20)];
        pressureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,471,rect.size.width,20)];
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,486,rect.size.width,20)];
        
        
        UIImageView *tempBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tempLabel10" ]];
        [tempBar setFrame:CGRectMake(0,418,rect.size.width,100)];
        [self.view addSubview:tempBar];

        
    }else{
        solLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70,rect.size.width,40)];
        atmosphereStringLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,145,rect.size.width,40)];
        atmosphereStringLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0,180,rect.size.width,40)];
        atmosphereLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,220,rect.size.width,80)];
        self.lowTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,335,rect.size.width,40)];
        self.highTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,353,rect.size.width,40)];
        pressureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,370,rect.size.width,40)];
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,384,rect.size.width,40)];
    
        
        UIImageView *tempBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tempLabel10" ]];
        [tempBar setFrame:CGRectMake(0,329,rect.size.width,100)];
        [self.view addSubview:tempBar];
        
    
    }
    
    
    if(self.home.sol){
        [_spinner stopAnimating];
        
       
        
        int fontSize = [Screen sizeFont:16 View:(UIView *)self.view];
        solLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:fontSize];
        solLabel.textAlignment = NSTextAlignmentCenter;
        solLabel.textColor = [UIColor blackColor];
        solLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Curiosity's trip: Day number %@",nil), [Numbers formatStr:self.home.sol Digits:3 Decimals:0]];
        [self.view addSubview:solLabel];
    }
    
    
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    NSLog(@" LOCALE %@", locale);
    
    NSString *atmosphereString1 = NSLocalizedStringWithDefaultValue(@"THE CURRENT WEATHER", @"Localizable", [NSBundle mainBundle], @"Weather", @"this is a comment");
    int fontSize = [Screen sizeFont:24 View:(UIView *)self.view];
    atmosphereStringLabel1.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    atmosphereStringLabel1.textColor = [UIColor whiteColor];
    atmosphereStringLabel1.textAlignment = NSTextAlignmentCenter;
    atmosphereStringLabel1.text = atmosphereString1;
    [self.view addSubview:atmosphereStringLabel1];
    
   
    
    NSString *atmosphereString2 = NSLocalizedString(@"ON MARS IS:", nil);
    fontSize = [Screen sizeFont:24 View:(UIView *)self.view];
    atmosphereStringLabel2.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    atmosphereStringLabel2.textColor = [UIColor whiteColor];
    atmosphereStringLabel2.textAlignment = NSTextAlignmentCenter;
    atmosphereStringLabel2.text = atmosphereString2;
    [self.view addSubview:atmosphereStringLabel2];
    
    
    
    
    
    if(self.home.atmosphere){
        NSString *atmosphere = [self.home.atmosphere uppercaseString];
        
        if ([atmosphere isEqualToString:@"SUNNY"]){
            atmosphere = NSLocalizedString(@"SUNNY", nil);
        }
        
        fontSize = [Screen sizeFont:60 View:(UIView *)self.view];
        atmosphereLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:70];
        atmosphereLabel.textColor = [UIColor whiteColor];
        atmosphereLabel.textAlignment = NSTextAlignmentCenter;
        atmosphereLabel.text = atmosphere;
        [self.view addSubview:atmosphereLabel];
    }
    
    
    self.lowTempLabel.tag = 400;
    if(self.home.lowTemp){
        fontSize = [Screen sizeFont:15 View:(UIView *)self.view];
        self.lowTempLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:fontSize];
        self.lowTempLabel.textColor = [UIColor blackColor];
        self.lowTempLabel.textAlignment = NSTextAlignmentCenter;
        self.lowTempLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Low Temperature: %@ %@", nil), [Numbers formatStr:[Math userTemp:self.home.lowTemp]Digits:2 Decimals:0], temperatureAbrev];
        [self.view addSubview:self.lowTempLabel];
    }
    
    
    self.highTempLabel.tag = 401;
    if(self.home.highTemp){
        fontSize = [Screen sizeFont:15 View:(UIView *)self.view];
        self.highTempLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:fontSize];
        self.highTempLabel.textColor = [UIColor blackColor];
        self.highTempLabel.textAlignment = NSTextAlignmentCenter;
        //while(YES){
        self.highTempLabel.text = [NSString stringWithFormat:NSLocalizedString(@"High Temperature: %@ %@", nil), [Numbers formatStr:[Math userTemp:self.home.highTemp]Digits:2 Decimals:0], temperatureAbrev];
       // }
        [self.view addSubview:self.highTempLabel];
    }
    
    
    if(self.home.pressureChange){
        if ([[self.home.pressureChange uppercaseString] isEqualToString:@"HIGHER"]){
            self.home.pressureChange = NSLocalizedString(@"HIGHER",nil);
        }
        else if ([[self.home.pressureChange uppercaseString] isEqualToString:@"LOWER"]){
            self.home.pressureChange = NSLocalizedString(@"LOWER",nil);
        }
        fontSize = [Screen sizeFont:11 View:(UIView *)self.view];
        pressureLabel.font = [UIFont fontWithName:@"verdana-Bold" size:fontSize];
        pressureLabel.textColor = [UIColor blackColor];
        pressureLabel.textAlignment = NSTextAlignmentCenter;
        pressureLabel.text = [NSString stringWithFormat:NSLocalizedString(@"The pressure is %@ Pa and getting %@.", nil), [Numbers formatStr:self.home.pressure Digits:3 Decimals:0], self.home.pressureChange];
        [self.view addSubview:pressureLabel];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"en"ofType:@"lproj"];
    NSLog(@"PATH - %@", path);
    
    
    NSLog(@"fill home view ... %@ ", self.home.date);
    if(self.home.date){
        fontSize = [Screen sizeFont:11 View:(UIView *)self.view];
        dateLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:fontSize];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Last updated: %@ (Earth time)", nil), [Numbers formatDate:self.home.date]];
        [self.view addSubview:dateLabel];
    }
    
    //////// frame
    
    

    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(1,0,2,rect.size.height)];
    leftLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftLabel];
    
    UILabel *leftHighlight = [[UILabel alloc] initWithFrame:CGRectMake(3,0,1,rect.size.height)];
    leftHighlight.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:leftHighlight];
    
    UILabel *leftLowlight = [[UILabel alloc] initWithFrame:CGRectMake(0,0,1,rect.size.height)];
    leftLowlight.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:leftLowlight];
    
    /////////// bottom
    
    UILabel *gradient2 = [[UILabel alloc] initWithFrame:CGRectMake(4,rect.size.height - 53,rect.size.width,1)];
    gradient2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:gradient2];
    
    UILabel *gradient3 = [[UILabel alloc] initWithFrame:CGRectMake(1,rect.size.height - 52,rect.size.width,4)];
    gradient3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:gradient3];
    
    UILabel *gradient4 = [[UILabel alloc] initWithFrame:CGRectMake(1,rect.size.height - 51,rect.size.width,1)];
    gradient4.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:gradient4];

    
    if (rect.size.height > 1000){
        
    }else if(rect.size.height > 560){
        
    }else{
        ////////////// bottom bar
        
        UILabel *gradient2 = [[UILabel alloc] initWithFrame:CGRectMake(4,rect.size.height - 53,rect.size.width,1)];
        gradient2.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:gradient2];
        
        UILabel *gradient3 = [[UILabel alloc] initWithFrame:CGRectMake(1,rect.size.height - 52,rect.size.width,2)];
        gradient3.backgroundColor = [UIColor grayColor];
        [self.view addSubview:gradient3];
        
        UILabel *gradient4 = [[UILabel alloc] initWithFrame:CGRectMake(1,rect.size.height - 50,rect.size.width,1)];
        gradient4.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:gradient4];

        
        ////////////// middle bar
        /*
        UILabel *barHighlight = [[UILabel alloc] initWithFrame:CGRectMake(4,331,rect.size.width,1)];
        barHighlight.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:barHighlight];
        
        UILabel *bar = [[UILabel alloc] initWithFrame:CGRectMake(4,332,rect.size.width,2)];
        bar.backgroundColor = [UIColor grayColor];
        [self.view addSubview:bar];
        
        UILabel *barLowlight = [[UILabel alloc] initWithFrame:CGRectMake(4,334,rect.size.width,1)];
        barLowlight.backgroundColor = [UIColor blackColor];
        [self.view addSubview:barLowlight];
        
        UIImageView *tempBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tempCover1" ]];
        [tempBar setFrame:CGRectMake(0,330,rect.size.width,150)];
        
        */
       // [self.view addSubview:tempBar];
        
        //UILabel *tempGray = [[UILabel alloc] initWithFrame:CGRectMake(4,337,rect.size.width,150)];
       // tempGray.backgroundColor = [UIColor darkGrayColor];
       // [self.view addSubview:tempGray];

    }

    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
        if (!self.home) {
        self.home = [[Home alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillHomeView) name:@"initWithJSONFinishedLoading" object:nil];
    }else{
    
        self.highTempLabel.text = [NSString stringWithFormat:NSLocalizedString(@"High Temperature: %@ %@", nil), [Math userTemp:self.home.highTemp], temperatureAbrev];
        self.lowTempLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Low Temperature: %@ %@", nil), [Math userTemp:self.home.lowTemp], temperatureAbrev];
    }
    
}
-(void)imageViewer
{
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    imageVC.name = @"Martian Landscape";
    imageVC.background = self.background;
    imageVC.credit = @"NASA/Curiosity";

    [self.navigationController pushViewController:imageVC animated:YES];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
