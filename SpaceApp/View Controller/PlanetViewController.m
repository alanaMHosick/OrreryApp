//
//  PlanetViewController.m
//  Space
//
//  Created by Alana Hosick on 1/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "PlanetViewController.h"
#import "Planet.h"
#import "PlanetInfo.h"
#import "Math.h"
#import "PlanetRiseViewController.h"
#import "URLcheck.h"
#import "SettingsViewController.h"
#import "UserLocation.h"
#import "PlanetRiseScrollViewController.h"
#import "Numbers.h"
#import "Colors.h"

@interface PlanetViewController ()

@end

@implementation PlanetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString([self.currentPlanet.name lowercaseString], nil);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startMonitoringSignificantLocationChanges];
    


    if(self.bodyNumber){
        [self loadSelfInformationFromTag:(int)self.bodyNumber];
    }
    
   
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:NSLocalizedString(@"Find times",nil)
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(risePressed)];
    rightButton.tintColor = [Colors barGreen] ;
    rightButton.tintColor = [Colors barGreen] ;
    self.navigationItem.rightBarButtonItem = rightButton;

	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.planetPicture]];
    if (self.view.bounds.size.height > 1000){
        imageView.frame = CGRectMake((self.view.bounds.size.width/2 - 200),200,(self.view.bounds.size.width/2 + 0),400);
    }else{
        imageView.frame = CGRectMake(10,10,300,300);
    }
    [self.view addSubview:imageView];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    if([URLcheck canConnectTo:@"http://www.google.com"]){
    
    self.date = [NSDate date];
    self.currentPlanet = [[Planet alloc]initPlanet:(NSString *)[self.planetName lowercaseString] Date:(NSDate *)self.date];
    self.earth = [[Planet alloc]initPlanet:@"earth" Date:(NSDate *)self.date];
    self.sun = [[Planet alloc]initPlanet:@"sun" Date:(NSDate *)self.date];

    }
    [self fillSplashView];
    
    }
- (id) loadSelfInformationFromTag:(int)tag
{
    CGRect rect = [self.view bounds];

    if(rect.size.height > 600){
        self.planetPicture = [PlanetInfo pictureArray][tag - 300];
    }else{
        self.planetPicture = [PlanetInfo pictureArray][tag - 300];
    }
    self.planetName = [[PlanetInfo bodyArray][tag - 300] lowercaseString];
    

    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *newLocation = locations.lastObject;
    
    self.latitude = newLocation.coordinate.latitude;
    self.longitude = newLocation.coordinate.longitude;
    
    NSLog(@"HERE");
    
    
    
}


- (void)fillSplashView
{
    
    [[self.view viewWithTag:200] removeFromSuperview];
    [[self.view viewWithTag:201] removeFromSuperview];
    [[self.view viewWithTag:202] removeFromSuperview];
    [[self.view viewWithTag:203] removeFromSuperview];
    [[self.view viewWithTag:204] removeFromSuperview];
    
    if(self.currentPlanet.x && self.currentPlanet.y && self.currentPlanet.z && self.earth.x && self.earth.y && self.earth.z){
         [_spinner stopAnimating];
    
    NSString *distance = [Math calculateDistanceX1:self.earth.x Y1:self.earth.y Z1:self.earth.z X2:self.currentPlanet.x Y2:self.currentPlanet.y Z2:self.currentPlanet.z];
        
        
        CGRect rect = [self.view bounds];
        int y;
        int font1;
        int font2;
        int smallSpace;
        int largeSpace;
        if(rect.size.height > 1000){
            y = 650;
            font1 = 40;
            font2 = 60;
            smallSpace = 90;
            largeSpace = 120;
           
        }
        else if(rect.size.height > 560){
            y = 350;
            font1 = 20;
            font2 = 30;
            smallSpace = 40;
            largeSpace = 60;
            
        }else{
            y = 280;
            font1 = 20;
            font2 = 30;
            smallSpace = 40;
            largeSpace = 60;

            
        }

        
        
        self.distance = distance;
        
        self.currentPlanet.distance = self.distance;
        
         NSLog(@"Distance: %@", distance);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,y,self.view.bounds.size.width,smallSpace)];
        y = y + largeSpace;
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,y,self.view.bounds.size.width,largeSpace)];
        y = y + smallSpace;
        UILabel *distanceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0,y,self.view.bounds.size.width,smallSpace)];
        
        titleLabel.font = [UIFont fontWithName:@"Verdana" size:font1];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = 200;
        titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ on %@:", nil), NSLocalizedString([self.currentPlanet.name lowercaseString], nil), [Numbers formatDate:[Math formatDate:self.date]]];
        [self.view addSubview:titleLabel];
        
        
        if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"ar"]){
        distanceLabel.font = [UIFont fontWithName:@"Verdana" size:font2];
        distanceLabel.textColor = [UIColor whiteColor];
        distanceLabel.tag = 201;
        distanceLabel.textAlignment = NSTextAlignmentCenter;
        distanceLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ %@", nil),[Numbers formatStr:[Math userDistance:distance] Digits: 1 Decimals:2],NSLocalizedString(distanceUnits, nil)];
        [self.view addSubview:distanceLabel];
        

        distanceLabel1.font = [UIFont fontWithName:@"Verdana" size:font1];
        distanceLabel1.textColor = [UIColor whiteColor];
        distanceLabel1.tag = 202;
        distanceLabel1.textAlignment = NSTextAlignmentCenter;
            distanceLabel1.text = [NSString stringWithFormat:NSLocalizedString(@"from Earth", nil)];
        [self.view addSubview:distanceLabel1];
        
        }else{
            
            distanceLabel.font = [UIFont fontWithName:@"Verdana" size:font2];
            distanceLabel.textColor = [UIColor whiteColor];
            distanceLabel.tag = 201;
            distanceLabel.textAlignment = NSTextAlignmentCenter;
            distanceLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@", nil),[Numbers formatStr:[Math userDistance:distance] Digits: 1 Decimals:2]];
            [self.view addSubview:distanceLabel];
            
            
            distanceLabel1.font = [UIFont fontWithName:@"Verdana" size:font1];
            distanceLabel1.textColor = [UIColor whiteColor];
            distanceLabel1.tag = 202;
            distanceLabel1.textAlignment = NSTextAlignmentCenter;
            distanceLabel1.text = [NSString stringWithFormat:NSLocalizedString(@"%@ from Earth", nil), NSLocalizedString(distanceUnits, nil)];
            [self.view addSubview:distanceLabel1];
    
            
            
            
            
            
            
        }
        if(![self.currentPlanet.name isEqualToString:@"earth"] && ![self.currentPlanet.name isEqualToString:@"sun"])
        {
     
            self.currentPlanet = ([Math findZenithPlanet:(Planet *)self.currentPlanet Earth:(Planet *)self.earth Sun:(Planet *)self.sun]);
            
        }
    }
}

- (void) risePressed
{
    PlanetRiseScrollViewController *planetRiseVC = [[PlanetRiseScrollViewController alloc] init];
    planetRiseVC.planet = self.currentPlanet;
    planetRiseVC.title = self.title;
    planetRiseVC.earth = self.earth;
    planetRiseVC.star = self.sun;
    planetRiseVC.latitude = self.latitude;
    planetRiseVC.longitude = self.longitude;
    planetRiseVC.distance = self.distance;
    [self.navigationController pushViewController:planetRiseVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.currentPlanet.x) {
        [super viewWillAppear:animated];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillSplashView) name:@"initWithJSONFinishedLoading" object:nil];
    }else{
        NSLog(@"Planet location loaded");
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    self.date = sender.date;
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
    
}

- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    
    self.currentPlanet = [[Planet alloc]initPlanet:(NSString *)[self.title lowercaseString] Date:(NSDate *)self.date];
    self.earth = [[Planet alloc]initPlanet:@"earth" Date:(NSDate *)self.date];
    self.sun = [[Planet alloc]initPlanet:@"sun" Date:(NSDate *)self.date];
    
    
    [self fillSplashView];
}

- (IBAction)callDP:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor whiteColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
}


@end
