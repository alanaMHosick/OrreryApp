//
//  OrreryViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/16/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "OrreryViewController.h"
#import "Math.h"
#import "Planet.h"
#import "PlanetInfo.h"
#import "Screen.h"
#import "URLcheck.h"
#import "SWRevealViewController.h"
//#import "RiseSetTransit.h"
#import "BodyPosition.h"
#import "SolarSystem.h"
#import "Numbers.h"
#import "Colors.h"

@interface OrreryViewController ()

@end

@implementation OrreryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Orrery page title", @"Localizable", [NSBundle mainBundle], @"Orrery", nil);
        self.tabBarItem.image = [UIImage imageNamed:@"moon-icon"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings14.png"]
                                                                         style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:NSLocalizedString(@"Date",nil)
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(callDP:)];
    rightButton.tintColor = [Colors barGreen] ;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"starfield"]];
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    if([URLcheck canConnectTo:@"http://www.astro-phys.com"]){
        NSDate *searchDate = [NSDate date];
        NSLog(@"searchDate: %@", searchDate);
        
        self.solarsystem = [[SolarSystem alloc] initSolarSystemFor:searchDate];
        
    }
    
    NSLog(@"VIEW DID LOAD");
    [self fillSplashView];
}

- (void) fillSplashView;

{
    [[self.view viewWithTag:301] removeFromSuperview];
    [[self.view viewWithTag:302] removeFromSuperview];
    [[self.view viewWithTag:303] removeFromSuperview];
    [[self.view viewWithTag:304] removeFromSuperview];
    [[self.view viewWithTag:305] removeFromSuperview];
    [[self.view viewWithTag:306] removeFromSuperview];
    [[self.view viewWithTag:307] removeFromSuperview];
    [[self.view viewWithTag:308] removeFromSuperview];
    [[self.view viewWithTag:309] removeFromSuperview];
    [[self.view viewWithTag:310] removeFromSuperview];
    
    
    NSString *searchDate;
    if(!self.date){
        searchDate = [Math getCurrentDate];
    }else{
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        searchDate = [dateFormat stringFromDate:self.date];
    }
    
    double r = [Screen radialMultiplierView:(UIView *)self.view];
    int sunButtonSize = [Screen sizePlanetButton:30 View:(UIView *)self.view];
    NSArray *imageArray = [PlanetInfo pictureArray];
    self.title = [Numbers formatDate:searchDate];
    
    CGRect viewRectT = [self.view bounds];
    //NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    
    int centerX = (viewRectT.size.width)/2 - (sunButtonSize/2);
    int centerY = (viewRectT.size.height)/2 - (sunButtonSize/2);
    
    if(self.solarsystem){
        
               
        self.sun = self.solarsystem.sun;
        self.mercury = self.solarsystem.mercury;
        self.venus = self.solarsystem.venus;
        self.earth = self.solarsystem.earth;
        self.mars = self.solarsystem.mars;
        self.jupiter = self.solarsystem.jupiter;
        self.saturn = self.solarsystem.saturn;
        self.uranus = self.solarsystem.uranus;
        self.neptune = self.solarsystem.neptune;
        
        
        [BodyPosition findEarthCenteredVars:(Planet *)self.sun Earth:(Planet *)self.earth Sun:(Planet *)self.sun Date:(NSDate *)searchDate];
        UIButton *sun = [UIButton buttonWithType:UIButtonTypeCustom];
        sun.tag = 300;
        [sun setFrame:CGRectMake(centerX, centerY, sunButtonSize, sunButtonSize)];
        UIImage *sunImage = [UIImage imageNamed:imageArray[sun.tag-300]];
        [sun setImage:sunImage forState:UIControlStateNormal];
        [self.view addSubview:sun];
        
        [_spinner stopAnimating];
        
        double angleMercury = [BodyPosition calculateAngleX:self.mercury.x Y:self.mercury.y];
        
        int mercuryX = (int)(centerX + self.mercury.graphDistance * r * cos(angleMercury));
        int mercuryY = (int)(centerY+ self.mercury.graphDistance * r * sin(angleMercury));
        
        int buttonSize = [Screen sizePlanetButton:10 View:(UIView *)self.view];
        UIButton *mercury = [UIButton buttonWithType:UIButtonTypeCustom];
        [mercury setFrame:CGRectMake(mercuryX, mercuryY, buttonSize, buttonSize)];
        mercury.tag = 301;
        UIImage *mercuryImage = [UIImage imageNamed:imageArray[mercury.tag-300]];
        [mercury setImage:mercuryImage forState:UIControlStateNormal];
        [self.view addSubview:mercury];
        
        
        double angleVenus = [BodyPosition calculateAngleX:self.venus.x Y:self.venus.y];
        
        int venusX = (int)(centerX + self.venus.graphDistance * r * cos(angleVenus));
        int venusY = (int)(centerY+ self.venus.graphDistance * r * sin(angleVenus));
        
        buttonSize = [Screen sizePlanetButton:11 View:(UIView *)self.view];
        UIButton *venus = [UIButton buttonWithType:UIButtonTypeCustom];
        [venus setFrame:CGRectMake(venusX, venusY, buttonSize, buttonSize)];
        venus.tag = 302;
        UIImage *venusImage = [UIImage imageNamed:imageArray[venus.tag-300]];
        [venus setImage:venusImage forState:UIControlStateNormal];
        [self.view addSubview:venus];
        
        
        double angleEarth = [BodyPosition calculateAngleX:self.earth.x Y:self.earth.y];
        
        int earthX = (int)(centerX + self.earth.graphDistance * r * cos(angleEarth));
        int earthY = (int)(centerY+ self.earth.graphDistance * r * sin(angleEarth));
        
        buttonSize = [Screen sizePlanetButton:15 View:(UIView *)self.view];
        UIButton *earth = [UIButton buttonWithType:UIButtonTypeCustom];
        [earth setFrame:CGRectMake(earthX, earthY, buttonSize, buttonSize)];
        earth.tag = 303;
        UIImage *earthImage = [UIImage imageNamed:imageArray[earth.tag-300]];
        [earth setImage:earthImage forState:UIControlStateNormal];
        [self.view addSubview:earth];
        
        double angleMars = [BodyPosition calculateAngleX:self.mars.x Y:self.mars.y];
        
        int marsX = (int)(centerX + self.mars.graphDistance * r * cos(angleMars));
        int marsY = (int)(centerY+ self.mars.graphDistance * r * sin(angleMars));
        
        buttonSize = [Screen sizePlanetButton:13 View:(UIView *)self.view];
        UIButton *mars = [UIButton buttonWithType:UIButtonTypeCustom];
        [mars setFrame:CGRectMake(marsX, marsY, buttonSize, buttonSize)];
        mars.tag = 305;
        UIImage *marsImage = [UIImage imageNamed:imageArray[mars.tag-300]];
        [mars setImage:marsImage forState:UIControlStateNormal];
        [self.view addSubview:mars];
        
        
        double angleJupiter = [BodyPosition calculateAngleX:self.jupiter.x Y:self.jupiter.y];
        
        int jupiterX = (int)(centerX + self.jupiter.graphDistance * r * cos(angleJupiter));
        int jupiterY = (int)(centerY+ self.jupiter.graphDistance * r * sin(angleJupiter));
        
        buttonSize = [Screen sizePlanetButton:23 View:(UIView *)self.view];
        UIButton *jupiter = [UIButton buttonWithType:UIButtonTypeCustom];
        [jupiter setFrame:CGRectMake(jupiterX, jupiterY, buttonSize, buttonSize)];
        jupiter.tag = 307;
        UIImage *jupiterImage = [UIImage imageNamed:imageArray[jupiter.tag-300]];
        [jupiter setImage:jupiterImage forState:UIControlStateNormal];
        [self.view addSubview:jupiter];
        
        
        double angleSaturn = [BodyPosition calculateAngleX:self.saturn.x Y:self.saturn.y];
        
        int saturnX = (int)(centerX + self.saturn.graphDistance * r * cos(angleSaturn));
        int saturnY = (int)(centerY+ self.saturn.graphDistance * r * sin(angleSaturn));
        
        buttonSize = [Screen sizePlanetButton:21 View:(UIView *)self.view];
        UIButton *saturn = [UIButton buttonWithType:UIButtonTypeCustom];
        [saturn setFrame:CGRectMake(saturnX, saturnY, buttonSize, buttonSize)];
        saturn.tag = 308;
        UIImage *saturnImage = [UIImage imageNamed:imageArray[saturn.tag-300]];
        [saturn setImage:saturnImage forState:UIControlStateNormal];
        [self.view addSubview:saturn];
        
        
        double angleUranus = [BodyPosition calculateAngleX:self.uranus.x Y:self.uranus.y];
        
        int uranusX = (int)(centerX + self.uranus.graphDistance * r * cos(angleUranus));
        int uranusY = (int)(centerY+ self.uranus.graphDistance * r * sin(angleUranus));
        
        buttonSize = [Screen sizePlanetButton:19 View:(UIView *)self.view];
        UIButton *uranus = [UIButton buttonWithType:UIButtonTypeCustom];
        [uranus setFrame:CGRectMake(uranusX, uranusY, buttonSize, buttonSize)];
        uranus.tag = 309;
        UIImage *uranusImage = [UIImage imageNamed:imageArray[uranus.tag-300]];
        [uranus setImage:uranusImage forState:UIControlStateNormal];
        [self.view addSubview:uranus];
        
        
        double angleNeptune = [BodyPosition calculateAngleX:self.neptune.x Y:self.neptune.y];
        
        int neptuneX = (int)(centerX + self.neptune.graphDistance * r * cos(angleNeptune));
        int neptuneY = (int)(centerY+ self.neptune.graphDistance * r * sin(angleNeptune));
        
        buttonSize = [Screen sizePlanetButton:16 View:(UIView *)self.view];
        UIButton *neptune = [UIButton buttonWithType:UIButtonTypeCustom];
        [neptune setFrame:CGRectMake(neptuneX, neptuneY, buttonSize, buttonSize)];
        neptune.tag = 310;
        UIImage *neptuneImage = [UIImage imageNamed:imageArray[neptune.tag-300]];
        [neptune setImage:neptuneImage forState:UIControlStateNormal];
        [self.view addSubview:neptune];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.solarsystem.sun.x) {
        [super viewWillAppear:animated];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillSplashView) name:@"initWithJSONFinishedLoading" object:nil];
    }else{
        NSLog(@"Planet location loaded");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    [_spinner startAnimating];
    
    if([URLcheck canConnectTo:@"http://www.google.com"]){
        self.solarsystem = [[SolarSystem alloc] initSolarSystemFor:self.date];
    }
    
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
    //[datePicker setDate:self.date animated:YES];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
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
    self.date = [datePicker date];
    [UIView commitAnimations];
}


@end
