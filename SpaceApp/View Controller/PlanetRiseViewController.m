//
//  PlanetRiseViewController.m
//  Space
//
//  Created by Alana Hosick on 2/2/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "PlanetRiseViewController.h"
#import "PlanetTimeViewController.h"
#import "Planet.h"
#import "PlanetInfo.h"
#import "Sun.h"
#import "Math.h"
#import "UserLocation.h"

#define kOFFSET_FOR_KEYBOARD 80.0;

@interface PlanetRiseViewController ()


@end


@implementation PlanetRiseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"title: %@", [self.title lowercaseString]);
    
   locationManager = [[CLLocationManager alloc] init];
   locationManager.delegate = self;
   locationManager.distanceFilter = kCLDistanceFilterNone;
   locationManager.desiredAccuracy = kCLLocationAccuracyBest;
   [locationManager startMonitoringSignificantLocationChanges];
   self.date = [NSDate date];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [self.tz setDelegate:self];

    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *newLocation = locations.lastObject;
    
    self.latitude = newLocation.coordinate.latitude;
    self.longitude = newLocation.coordinate.longitude;
    
    NSLog(@"HERE");
    
    [self fillSplashView];
    
}

- (void)fillSplashView
{
    self.userLocation = [[UserLocation alloc] initUserLongitude:self.longitude Latitude:self.latitude];
    
    CGRect rect = [self.view bounds];
    int y;
    int dstLabelHeight = 50;
    int spacer;
    int labelHeight;
    int font;
    int rightMargin;
    int leftMargin;
    if (rect.size.height > 1000){
        y = 150;
        spacer = 80;
        labelHeight = 80;
        font = 45;
        leftMargin = 50;
        rightMargin = 100;
    }
    else if (rect.size.height > 560){
        y = 100;
        spacer = 45;
        labelHeight = 40;
        font = 20;
        leftMargin = 20;
        rightMargin = 40;
        
        
    }else{
        y = 80;
        spacer = 25;
        labelHeight = 25;
        font = 15;
        leftMargin = 20;
        rightMargin = 40;
    }
    
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    y = y +spacer;
    
    UILabel *latLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y, rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    self.lat = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)]; //12 300
    y = y + spacer;
    
    UILabel *longLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    self.lon = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 300
    y = y + spacer;
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    UIButton *date = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    date.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    
     y = y + spacer;
    
    UILabel *tzLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y, rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    self.tz = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)]; //12 300
    y = y + spacer;
    
    UILabel *eleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    self.ele = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 300
    y = y + spacer;

    
    
    
    
    y = y + (0.5 *spacer);// + ( 0.5 * spacer);
    
    UILabel *dstLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - (rect.size.width/2),dstLabelHeight)];//12 200
    self.dst = [[UISwitch alloc] initWithFrame:(CGRectMake((rect.size.width - (rect.size.width / 3)),y+10,30,dstLabelHeight))];//220 30
    
    
    latLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    latLabel.textColor = [UIColor whiteColor];
    latLabel.textAlignment = NSTextAlignmentCenter;
    latLabel.text = [NSString stringWithFormat:NSLocalizedString(@"latitude",nil)];
    [self.view addSubview:latLabel];
    
    self.lat.font = [UIFont fontWithName:@"Helvetica" size:font];
    self.lat.textColor = [UIColor blackColor];
    self.lat.text = [NSString stringWithFormat:@"%Lf", self.latitude];
    self.lat.backgroundColor = [UIColor whiteColor];
    self.lat.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.lat.keyboardAppearance = UIKeyboardAppearanceDark;
    self.lat.returnKeyType = UIReturnKeyDone;
    if (self.lat.placeholder != nil) {
        self.lat.clearsOnBeginEditing = NO;
    }
    self.lat.delegate = self;
    [self.lat resignFirstResponder];
    [self.view addSubview:self.lat];
    
    
    longLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    longLabel.textColor = [UIColor whiteColor];
    longLabel.textAlignment = NSTextAlignmentCenter;
    longLabel.text = [NSString stringWithFormat:NSLocalizedString(@"longitude",nil)];
    [self.view addSubview:longLabel];
    
    self.lon.font = [UIFont fontWithName:@"Helvetica" size:font];
    self.lon.textColor = [UIColor blackColor];
    self.lon.text = [NSString stringWithFormat:@"%Lf", self.longitude];
    self.lon.backgroundColor = [UIColor whiteColor];
    self.lat.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.lon.keyboardAppearance = UIKeyboardAppearanceDark;
    self.lon.returnKeyType = UIReturnKeyDone;
    if (self.lon.placeholder != nil) {
        self.lon.clearsOnBeginEditing = NO;
    }
    self.lon.delegate = self;
    [self.lon resignFirstResponder];
    [self.view addSubview:self.lon];
    
    
    
    tzLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    tzLabel.textColor = [UIColor whiteColor];
    tzLabel.textAlignment = NSTextAlignmentCenter;
    tzLabel.text = [NSString stringWithFormat:NSLocalizedString(@"timezone",nil)];
    [self.view addSubview:tzLabel];
    
    self.tz.font = [UIFont fontWithName:@"Helvetica" size:font];
    self.tz.textColor = [UIColor blackColor];
    self.tz.backgroundColor = [UIColor whiteColor];
    self.tz.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.tz.keyboardAppearance = UIKeyboardAppearanceDark;
    self.tz.returnKeyType = UIReturnKeyDone;
    NSLog(@"userlocation timezone: %d",userTimezone);
    if(timezoneName){
        [_spinner stopAnimating];
    self.tz.text = [NSString stringWithFormat:@"%d   -   %@", userTimezone, timezoneName];
    }
    if (self.tz.placeholder != nil) {
        self.tz.clearsOnBeginEditing = NO;
    }
    self.tz.delegate = self;
    [self.tz resignFirstResponder];
    

    [self.view addSubview:self.tz];
    
    
    eleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    eleLabel.textColor = [UIColor whiteColor];
    eleLabel.textAlignment = NSTextAlignmentCenter;
    eleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"elevation (meters)",nil)];
    [self.view addSubview:eleLabel];
    
    self.ele.font = [UIFont fontWithName:@"Helvetica" size:font];
    self.ele.textColor = [UIColor blackColor];
    self.ele.text = [NSString stringWithFormat:@"%f", userElevation];
    self.ele.backgroundColor = [UIColor whiteColor];
    self.ele.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.ele.keyboardAppearance = UIKeyboardAppearanceDark;
    self.ele.returnKeyType = UIReturnKeyDone;
    if (self.ele.placeholder != nil) {
        self.ele.clearsOnBeginEditing = NO;
    }
    self.ele.delegate = self;
    [self.ele resignFirstResponder];
    [self.view addSubview:self.ele];

    
    
    
    dstLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    dstLabel.textColor = [UIColor whiteColor];
    dstLabel.textAlignment = NSTextAlignmentCenter;
    dstLabel.text = [NSString stringWithFormat:NSLocalizedString(@"daylight savings?",nil)];
    [self.view addSubview:dstLabel];
    
    [self.view addSubview:self.dst];
    
    dateLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"date",nil)];
    [self.view addSubview:dateLabel];
    
    date.backgroundColor =[UIColor whiteColor];
    date.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];

    [date setTitle:[Math formatDate:self.date] forState:UIControlStateNormal];
    [self.view addSubview:date];
    [date addTarget:self action:@selector(callDP:)forControlEvents:UIControlEventTouchUpInside];
    
    date.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:date];
    
    submit.backgroundColor =[UIColor yellowColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:font];
    [submit setTitle:NSLocalizedString(@"find rise/set times", nil) forState:UIControlStateNormal];
    [self.view addSubview:submit];
    [submit addTarget:self action:@selector(submitPressed)forControlEvents:UIControlEventTouchUpInside];
    
    
}











- (void)viewWillAppear:(BOOL)animated
{
        if (self.userLocation) {
        self.userLocation = [[UserLocation alloc] init];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(120, 230, 50, 50);
        activityIndicator.center = self.view.center;
        [self.view addSubview: activityIndicator];
        [activityIndicator startAnimating];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillSplashView) name:@"initWithJSON1FinishedLoading" object:nil];
    }else{
        NSLog(@"GPS information loaded");
    }
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    //[textField resignFirstResponder];
//    [self.view endEditing:YES];
//    return YES;
//}

- (id) submitPressed
{
    NSLog(@"SUBMIT TIMEZONE:  %d",userTimezone);
    if (![self.tz.text isEqualToString:@""]){
        userTimezone = [self.tz.text integerValue];
    }
    if (![self.ele.text isEqualToString:@""]){
        userElevation = [self.ele.text integerValue];
    }
    
    PlanetTimeViewController *planetTimeVC = [[PlanetTimeViewController alloc] init];
    
    NSLog(@"sun %@", self.lon.text);
    NSLog(@"sun %@", self.lat.text);
    
    NSLog(@"sun %f", [self.lon.text doubleValue]);
    NSLog(@"sun %f", [self.lat.text doubleValue]);
    
    planetTimeVC.planet = self.planet;
    planetTimeVC.longitude = [self.lon.text doubleValue];  //doubleValue];
    planetTimeVC.dst = self.dst.isOn;
    planetTimeVC.latitude = [self.lat.text doubleValue];
    planetTimeVC.title = NSLocalizedString(@"rise/set", nil);
    planetTimeVC.date = self.date;
    planetTimeVC.userlocation = self.userLocation;
    
    [self.navigationController pushViewController:planetTimeVC animated:YES];
    
    return self;
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
    
    //TODO - set method to use date and lat
    
    [self fillSplashView];
}

- (IBAction)callDP:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-216, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 9;
    darkView.backgroundColor = [UIColor whiteColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.tag = 10;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)];
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    self.date = [datePicker date];
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
