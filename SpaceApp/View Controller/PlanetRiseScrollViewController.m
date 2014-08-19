//
//  PlanetRiseScrollViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/22/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "PlanetRiseScrollViewController.h"
#import "PlanetRiseViewController.h"
#import "PlanetTimeViewController.h"
#import "Planet.h"
//#import "PlanetInfo.h"
#import "Sun.h"
#import "Math.h"
#import "UserLocation.h"
#import "Zones.h"
#import "ImageViewController.h"
#import "TimezoneViewController.h"
#import "ErrorAlert.h"
#import "Numbers.h"
#import "Colors.h"

#define kOFFSET_FOR_KEYBOARD 80.0;


@interface PlanetRiseScrollViewController ()

@end

@implementation PlanetRiseScrollViewController

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
    
   
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startMonitoringSignificantLocationChanges];
    self.date = [NSDate date];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:NSLocalizedString(@"GPS Data",nil)
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(callGPS:)];
    rightButton.tintColor = [Colors barGreen] ;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320,580);
    self.scrollView.backgroundColor = [UIColor darkGrayColor];
    
    
    NSLog(@"title: %@", [self.title lowercaseString]);

    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [self.tz setDelegate:self];
    
     [self fillSplashView];
    
    
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
    
    NSLog(@"%Lf", self.latitude);
    NSLog(@"%Lf", self.longitude);
    
   self.userLocation =  [[UserLocation alloc] initUserLongitude:self.longitude Latitude:self.latitude];
    NSDateFormatter *dateFormatter;
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    if(!dstBool){
        dstBool = NO;
    }
    if(!userElevation){
        userElevation = 0;
    }
    if(!userTimezone){
        userTimezone = 0;
    }
    if(!timezoneName){
        timezoneName = @"GMT";
    }
    
    UIColor *textboxColor = [UIColor whiteColor];
    UIColor *textboxFontColor = [UIColor darkGrayColor];
    UIColor *labelFontColor = [UIColor whiteColor];
    UIColor *buttonColor = [UIColor colorWithRed: 104 green:204 blue:20 alpha:1];
    
    CGRect rect = [self.view bounds];
    int y;
    int dstLabelHeight = 50;
    int spacer;
    int labelHeight;
    int font;
    int rightMargin;
    int leftMargin;
    int rightShadowOffset;
    int lowerShadowOffset;
    UIImage *shadowImage;
    UIImage *switchShadowImage;
    UIImage *buttonCover;
    
    if (rect.size.height > 1000){
        y = 90;
        spacer = 60;
        labelHeight = 60;
        font = 30;
        leftMargin = 50;
        rightMargin = 100;
        rightShadowOffset = 65;
        lowerShadowOffset = 38;
        shadowImage = [UIImage imageNamed:@"textBoxShadowLg2.png"];
        //switchShadowImage = [UIImage imageNamed:(@"switchShadow2.png")];
        buttonCover = [UIImage imageNamed:(@"buttonCover2.png")];
    }
    else if (rect.size.height > 560){
        y = 100;
        spacer = 30;
        labelHeight = 25;
        font = 16;
        leftMargin = 20;
        rightMargin = 40;
        rightShadowOffset = 45;
        lowerShadowOffset = 28;
        shadowImage = [UIImage imageNamed:@"textBoxShadow.png"];
        switchShadowImage = [UIImage imageNamed:(@"switchShadow2.png")];
        buttonCover = [UIImage imageNamed:(@"buttonCover2.png")];
        
        
    }else{
        y = 70;
        spacer = 25;
        labelHeight = 25;
        font = 13;
        leftMargin = 20;
        rightMargin = 40;
        rightShadowOffset = 45;
        lowerShadowOffset = 28;
        shadowImage = [UIImage imageNamed:@"textBoxShadow.png"];
        switchShadowImage = [UIImage imageNamed:(@"switchShadow2.png")];
        buttonCover = [UIImage imageNamed:(@"buttonCover2.png")];
    }
    UIFont *labelFont = [UIFont fontWithName:@"Verdana" size:font];
    
    
    
    UILabel *latLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y, rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    UIImageView *a=[[UIImageView alloc] initWithImage:shadowImage];
    [a setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+rightShadowOffset,labelHeight + lowerShadowOffset)];
    //[a setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+45,labelHeight + 28)]; //Adjust X,Y,W,H as needed
    [self.scrollView addSubview:a];
    
       self.lat = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)]; //12 300
    
    UIImageView *buttonCover5 = [[UIImageView alloc] initWithImage:buttonCover];
    [buttonCover5 setFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];
   
    y = y + spacer;
    
    
    
    UILabel *longLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    UIImageView *b=[[UIImageView alloc] initWithImage:shadowImage];
    [b setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+rightShadowOffset,labelHeight + lowerShadowOffset)];
    [self.scrollView addSubview:b];
    
    self.lon = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 300
    
    UIImageView *buttonCover6 = [[UIImageView alloc] initWithImage:buttonCover];
    [buttonCover6 setFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];
    
    y = y + spacer;
    
    
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
        UIImageView *c =[[UIImageView alloc] initWithImage:shadowImage];
    [c setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+rightShadowOffset,labelHeight + lowerShadowOffset)];
    [self.scrollView addSubview:c];
    
    

    UIButton *date = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    date.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    
    UIImageView *buttonCover1 = [[UIImageView alloc] initWithImage:buttonCover];
    [buttonCover1 setFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];
    

    
    y = y + spacer;
    
    
    
    UILabel *tzLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y, rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    
    UIImageView *d=[[UIImageView alloc] initWithImage:shadowImage];
    [d setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+rightShadowOffset,labelHeight + lowerShadowOffset)];
    [self.scrollView addSubview:d];

    
    self.timezoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.timezoneButton.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
    UIImageView *buttonCover2 = [[UIImageView alloc] initWithImage:buttonCover];
    [buttonCover2 setFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];

    
    y = y + spacer;
    
    
    
    UILabel *eleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 280
    y = y + spacer;
    
    UIImageView *e =[[UIImageView alloc] initWithImage:shadowImage];
    [e setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+rightShadowOffset,labelHeight + lowerShadowOffset)];
    
    [self.scrollView addSubview:e];

    self.ele = [[UITextField alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];//12 300
    
    UIImageView *buttonCover3 = [[UIImageView alloc] initWithImage:buttonCover];
    [buttonCover3 setFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];

    y = y + spacer;
    
    
    
    y = y + (0.2 *spacer);// + ( 0.5 * spacer);
    
    UILabel *dstLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin,y,rect.size.width - (rect.size.width/2),dstLabelHeight)];//12 200
    
    UIImageView *switchShadow =[[UIImageView alloc] initWithImage:switchShadowImage];
    [switchShadow setFrame:CGRectMake((rect.size.width - (rect.size.width / 3)) - 11,y-2,(rect.size.width - (rect.size.width / 3))-135,dstLabelHeight + 10)];
    
    [self.scrollView addSubview:switchShadow];
    
    self.dst = [[UISwitch alloc] initWithFrame:(CGRectMake((rect.size.width - (rect.size.width / 3)),y+10,30,dstLabelHeight))];//220 30
    
     y = y + spacer + spacer;
    
    
    UIImageView *f=[[UIImageView alloc] initWithImage:shadowImage];
    [f setFrame:CGRectMake(leftMargin - 20,y-10,rect.size.width - (rightMargin)+rightShadowOffset,labelHeight + lowerShadowOffset)];
    [self.scrollView addSubview:f];

    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame = CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight);
   
    UIImageView *buttonCover4 = [[UIImageView alloc] initWithImage:buttonCover];
    [buttonCover4 setFrame:CGRectMake(leftMargin,y,rect.size.width - rightMargin,labelHeight)];

    
    
    latLabel.font = labelFont;
    latLabel.textColor = labelFontColor;
    latLabel.textAlignment = NSTextAlignmentCenter;
    latLabel.text = [NSString stringWithFormat:NSLocalizedString(@"latitude",nil)];
    [self.scrollView addSubview:latLabel];
    
    self.lat.font = labelFont;
    self.lat.textColor = textboxFontColor;
    self.lat.textAlignment = NSTextAlignmentCenter;
    self.lat.backgroundColor = textboxColor;
    self.lat.borderStyle = UITextBorderStyleBezel;
    self.lat.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.lat.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.lat.keyboardAppearance = UIKeyboardAppearanceDark;
    self.lat.returnKeyType = UIReturnKeyDone;
    if (self.lat.placeholder != nil) {
        self.lat.clearsOnBeginEditing = NO;
    }
    self.lat.delegate = self;
    [self.lat resignFirstResponder];
    [self.scrollView addSubview:self.lat];
    
    
    longLabel.font = labelFont;
    longLabel.textColor = labelFontColor;
    longLabel.textAlignment = NSTextAlignmentCenter;
    longLabel.text = [NSString stringWithFormat:NSLocalizedString(@"longitude",nil)];
    [self.scrollView addSubview:longLabel];
    
    self.lon.font = labelFont;
    self.lon.textColor = textboxFontColor;
    self.lon.textAlignment = NSTextAlignmentCenter;
    self.lon.backgroundColor = textboxColor;
    self.lon.borderStyle = UITextBorderStyleBezel;
    self.lat.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.lon.keyboardAppearance = UIKeyboardAppearanceDark;
    self.lon.returnKeyType = UIReturnKeyDone;
    if (self.lon.placeholder != nil) {
        self.lon.clearsOnBeginEditing = NO;
    }
    self.lon.delegate = self;
    [self.lon resignFirstResponder];
    [self.scrollView addSubview:self.lon];
    
    
    
    tzLabel.font = labelFont;
    tzLabel.textColor = labelFontColor;
    tzLabel.textAlignment = NSTextAlignmentCenter;
    tzLabel.text = [NSString stringWithFormat:NSLocalizedString(@"timezone",nil)];
    [self.scrollView addSubview:tzLabel];
    
    
    self.timezoneButton.backgroundColor =[UIColor whiteColor];
    self.timezoneButton.titleLabel.font = labelFont;
    
    
    [self.timezoneButton setTitle:[NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   %@  ", @"this is a comment"), userTimezone , [Zones zone:[NSString stringWithFormat:@"%d",userTimezone]]] forState:UIControlStateNormal];
    [self.scrollView addSubview:self.timezoneButton];
    [self.timezoneButton addTarget:self action:@selector(callTimezone:)forControlEvents:UIControlEventTouchUpInside];
    
    self.timezoneButton.backgroundColor =[UIColor whiteColor];
    
    eleLabel.font = labelFont;
    eleLabel.textColor = labelFontColor;
    eleLabel.textAlignment = NSTextAlignmentCenter;
    eleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"elevation (meters)",nil)];
    [self.scrollView addSubview:eleLabel];
    
    self.ele.font = labelFont;
    self.ele.textColor = textboxFontColor;
    self.ele.borderStyle = UITextBorderStyleBezel;
    self.ele.text = [NSString stringWithFormat:@"%.0f", userElevation];
    self.ele.backgroundColor = [UIColor whiteColor];
    self.ele.textAlignment = NSTextAlignmentCenter;
    self.ele.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.ele.keyboardAppearance = UIKeyboardAppearanceDark;
    self.ele.returnKeyType = UIReturnKeyDone;
    if (self.ele.placeholder != nil) {
        self.ele.clearsOnBeginEditing = NO;
    }
    self.ele.delegate = self;
    [self.ele resignFirstResponder];
    [self.scrollView addSubview:self.ele];
    
    
    
    
    dstLabel.font = labelFont;
    dstLabel.textColor = labelFontColor;
    dstLabel.textAlignment = NSTextAlignmentCenter;
    dstLabel.text = [NSString stringWithFormat:NSLocalizedString(@"daylight savings?",nil)];
    [self.scrollView addSubview:dstLabel];
    
    [self.scrollView addSubview:self.dst];
    
    dateLabel.font = labelFont;
    dateLabel.textColor = labelFontColor;
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"date",nil)];
    [self.scrollView addSubview:dateLabel];
    
    date.backgroundColor =textboxColor;
    date.titleLabel.font = labelFont;
    
    [date setTitle:[Numbers formatDate:[Math formatDate:self.date] ]forState:UIControlStateNormal];
    [self.scrollView addSubview:date];
    [date addTarget:self action:@selector(callDP:)forControlEvents:UIControlEventTouchUpInside];
    
    date.backgroundColor =labelFontColor;
    
    [self.scrollView addSubview:date];
    
    
    submit.backgroundColor = buttonColor;
    //submit.appearance = UITextBorderStyleBezel;
    submit.titleLabel.font = labelFont;
    [submit setTitle:NSLocalizedString(@"find rise/set times", nil) forState:UIControlStateNormal];
    [self.scrollView addSubview:submit];
    [submit addTarget:self action:@selector(submitPressed)forControlEvents:UIControlEventTouchUpInside];
    
         [self.scrollView addSubview:latLabel];
    
    [self.scrollView addSubview:buttonCover1];
    [self.scrollView addSubview:buttonCover2];
    [self.scrollView addSubview:buttonCover3];
    [self.scrollView addSubview:buttonCover4];
    [self.scrollView addSubview:buttonCover5];
    [self.scrollView addSubview:buttonCover6];
    [self.view addSubview:self.scrollView];
}



-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"View appeared.");
    [self.timezoneButton setTitle:[NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   %@  ", @"this is a comment"), userTimezone , [Zones zone:[NSString stringWithFormat:@"%d",userTimezone]]] forState:UIControlStateNormal];

}







-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.tz){
        //timezone = [self.tz.text integerValue];
        NSLog(@" ZONE (%@)", self.tz.text);
        NSString *zoneString = [self.tz.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        NSLog(@" ZONE (%@)", zoneString);

        NSString *s = [Zones zone:(NSString *)zoneString];
        timezoneName = s;
        self.tz2.text = timezoneName;
        NSLog(@" ZONE %@", s);
    }
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)callGPS:(id)sender {
    self.ele.text = [NSString stringWithFormat:@"%.0f", userElevation];
    self.lon.text = [NSString stringWithFormat:@"%Lf", self.longitude];
    self.lat.text = [NSString stringWithFormat:@"%Lf", self.latitude];
    if(dstBool){
        [self.dst setOn:YES animated:YES];
    }else{
        [self.dst setOn:NO animated:YES];
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if([textField isFirstResponder])
    {
        NSLog(@" FIRST RESPONDER");
        if (textField == self.tz){
        self.scrollView.contentOffset = CGPointMake(0,100);
            if ([textField.text isEqualToString:@""]) {
               // [self dateChanged:nil];
            }
        }else if (textField == self.ele){
            self.scrollView.contentOffset = CGPointMake(0,200);
        }
    }
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    [self.tz setText:[pickerArray objectAtIndex:row]];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (id) callTimezone:(id)sender
{
   // NSLog(@"SUBMIT TIMEZONE:  %d",userTimezone);
    if (![self.tz.text isEqualToString:@""]){
        userTimezone = (int)[self.tz.text integerValue];
    }
    if (![self.ele.text isEqualToString:@""]){
        userElevation = [self.ele.text integerValue];
    }
    
    TimezoneViewController *tzVC = [[TimezoneViewController alloc] init];
    
    NSLog(@"sun %@", self.lon.text);
    NSLog(@"sun %@", self.lat.text);
    
    NSLog(@"sun %f", [self.lon.text doubleValue]);
    NSLog(@"sun %f", [self.lat.text doubleValue]);
    
    tzVC.userlocation = self.userLocation;
    
    [self.navigationController pushViewController:tzVC animated:YES];
    
    return self;
}


- (id) submitPressed
{
    if (![self.ele.text isEqualToString:@""]){
        userElevation = [self.ele.text integerValue];
    }
    NSLog(@"longitude %f", [self.lon.text doubleValue]);
    if(([self.lon.text doubleValue] == 0) || ([self.lon.text doubleValue] < -180) || ([self.lon.text doubleValue] > 180) ){
        [ErrorAlert inputErrorAlert:(NSLocalizedString(@"Please enter a valid longitude.", nil))];
         NSLog(@"longitude: %f:", [self.lon.text doubleValue]);
        
    }else if(([self.lat.text doubleValue] == 0) || ([self.lat.text doubleValue] < -90) || ([self.lat.text doubleValue] > 90) ){
        [ErrorAlert inputErrorAlert:(NSLocalizedString(@"Please enter a valid latitude.", nil))];
         NSLog(@"latitude");
   }else if(!(userTimezone >= -12 && userTimezone <= 12)){
        [ErrorAlert inputErrorAlert:(NSLocalizedString(@"Please enter a valid timezone.", nil))];
       NSLog(@"timezone");
   }else{
    
       PlanetTimeViewController *planetTimeVC = [[PlanetTimeViewController alloc] init];
       planetTimeVC.planet = self.planet;
       planetTimeVC.longitude = [self.lon.text doubleValue];
       planetTimeVC.dst = self.dst.isOn;
       planetTimeVC.latitude = [self.lat.text doubleValue];
       planetTimeVC.title = NSLocalizedString(@"rise/set", nil);
       planetTimeVC.date = self.date;
       planetTimeVC.distance = self.distance;
       
       [self.navigationController pushViewController:planetTimeVC animated:YES];
    }
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
