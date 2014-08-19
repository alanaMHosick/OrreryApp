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


@interface CuriosityViewController ()

@end

@implementation CuriosityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Curiosity";
        self.tabBarItem.image = [UIImage imageNamed:@"Wall-E-icon"];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MarsLandscapeNASA2.jpg"]];//Mars3.jpg"]];
    
    Home *home = [[Home alloc] init];
    NSLog(@"view did load%@", home.date);
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [self fillHomeView];
}

- (void) fillHomeView;

{
    
    UILabel *solLabel = [[UILabel alloc] initWithFrame:[Screen solLabelView:self.view]];
    if(self.home.sol){
        [_spinner stopAnimating];
        int fontSize = [Screen sizeFont:19 View:(UIView *)self.view];
        solLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        solLabel.textAlignment = NSTextAlignmentCenter;
        solLabel.textColor = [UIColor whiteColor];
        solLabel.text = [NSString stringWithFormat:@"Curiosity's trip: Day number %@", self.home.sol];
        [self.view addSubview:solLabel];
    }
    
    UILabel *atmosphereStringLabel1 = [[UILabel alloc] initWithFrame:[Screen atmosphereStringLabel1:self.view]];
    
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    NSLog(@" LOCALE %@", locale);
    
    NSString *atmosphereString1 = NSLocalizedStringWithDefaultValue(@"THE CURRENT WEATHER", @"Localizable", [NSBundle mainBundle], @"Weather", @"this is a comment");
    int fontSize = [Screen sizeFont:22 View:(UIView *)self.view];
    atmosphereStringLabel1.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    atmosphereStringLabel1.textColor = [UIColor whiteColor];
    atmosphereStringLabel1.textAlignment = NSTextAlignmentCenter;
    atmosphereStringLabel1.text = atmosphereString1;
    [self.view addSubview:atmosphereStringLabel1];
    
    UILabel *atmosphereStringLabel2 = [[UILabel alloc] initWithFrame:[Screen atmosphereStringLabel2:self.view]];
    
    NSString *atmosphereString2 = @"ON MARS IS:";
    fontSize = [Screen sizeFont:22 View:(UIView *)self.view];
    atmosphereStringLabel2.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    atmosphereStringLabel2.textColor = [UIColor whiteColor];
    atmosphereStringLabel2.textAlignment = NSTextAlignmentCenter;
    atmosphereStringLabel2.text = atmosphereString2;
    [self.view addSubview:atmosphereStringLabel2];
    
    
    
    UILabel *atmosphereLabel = [[UILabel alloc] initWithFrame:[Screen atmosphereLabel:self.view]];
    
    if(self.home.atmosphere){
        NSString *atmosphere = [self.home.atmosphere uppercaseString];
        fontSize = [Screen sizeFont:55 View:(UIView *)self.view];
        atmosphereLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        atmosphereLabel.textColor = [UIColor whiteColor];
        atmosphereLabel.textAlignment = NSTextAlignmentCenter;
        atmosphereLabel.text = atmosphere;
        [self.view addSubview:atmosphereLabel];
    }
    
    UILabel *lowTempLabel = [[UILabel alloc] initWithFrame:[Screen lowTempLabel:self.view]];
    if(self.home.lowTemp){
        fontSize = [Screen sizeFont:20 View:(UIView *)self.view];
        lowTempLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        lowTempLabel.textColor = [UIColor whiteColor];
        lowTempLabel.textAlignment = NSTextAlignmentCenter;
        lowTempLabel.text = [NSString stringWithFormat:@"Low Temperature: %@ F", self.home.lowTemp];
        [self.view addSubview:lowTempLabel];
    }
    
    UILabel *highTempLabel = [[UILabel alloc] initWithFrame:[Screen highTempLabel:self.view]];
    if(self.home.highTemp){
        fontSize = [Screen sizeFont:20 View:(UIView *)self.view];
        highTempLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        highTempLabel.textColor = [UIColor whiteColor];
        highTempLabel.textAlignment = NSTextAlignmentCenter;
        highTempLabel.text = [NSString stringWithFormat:@"High Temperature: %@ F", self.home.highTemp];
        [self.view addSubview:highTempLabel];
    }
    
    UILabel *pressureLabel = [[UILabel alloc] initWithFrame:[Screen pressureLabel:self.view]];
    if(self.home.highTemp){
        fontSize = [Screen sizeFont:14.5 View:(UIView *)self.view];
        pressureLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        pressureLabel.textColor = [UIColor whiteColor];
        pressureLabel.textAlignment = NSTextAlignmentCenter;
        pressureLabel.text = [NSString stringWithFormat:@"The pressure is %@ Pa and getting %@.", self.home.pressure, self.home.pressureChange];
        [self.view addSubview:pressureLabel];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"en"ofType:@"lproj"];
    NSLog(@"PATH - %@", path);
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:[Screen dateLabel:self.view]];
    NSLog(@"fill home view ... %@ ", self.home.date);
    if(self.home.date){
        fontSize = [Screen sizeFont:14.5 View:(UIView *)self.view];
        dateLabel.font = [UIFont fontWithName:@"Helvetica" size:fontSize];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Last updated: %@ (Earth time)", nil), self.home.date];
        [self.view addSubview:dateLabel];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.home) {
        self.home = [[Home alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillHomeView) name:@"initWithJSONFinishedLoading" object:nil];
    }else{
        NSLog(@"view did load%@", self.home.date);
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
