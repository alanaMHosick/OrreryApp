//
//  ViewerViewController.m
//  Space
//
//  Created by Alana Hosick on 1/28/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "ViewerViewController.h"
#import "Math.h"
#import "Planet.h"
#import "PlanetViewController.h"
#import "Screen.h"
#import "PlanetInfo.h"
#import "URLcheck.h"
#import "SWRevealViewController.h"
#import "SolarSystem.h"
#import "Numbers.h"
#import "Colors.h"

@interface ViewerViewController ()

@end

@implementation ViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"View page title", @"Localizable", [NSBundle mainBundle], @"View", nil);
        self.tabBarItem.image = [UIImage imageNamed:@"telescope30.png"];
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
                                    initWithTitle:NSLocalizedString(@"Date", nil)
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(callDP:)];
    rightButton.tintColor = [Colors barGreen] ;
    self.navigationItem.rightBarButtonItem = rightButton;
    
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[Screen ViewerBackgroundImages][[Screen sizeBackground:self.view]]]];
    
    NSDate *searchDate = [NSDate date];
    NSLog(@"searchDate: %@", searchDate);
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    //if([URLcheck canConnectTo:@"http://www.astro-phys.com"]){
    
        self.solarsystem = [[SolarSystem alloc] initSolarSystemFor:searchDate];
    //}
   
    [self fillSplashView];
}

- (void) fillSplashView;

{
    
    [[self.view viewWithTag:301] removeFromSuperview];
    [[self.view viewWithTag:302] removeFromSuperview];
    [[self.view viewWithTag:304] removeFromSuperview];
    [[self.view viewWithTag:305] removeFromSuperview];
    [[self.view viewWithTag:306] removeFromSuperview];
    [[self.view viewWithTag:307] removeFromSuperview];
    [[self.view viewWithTag:308] removeFromSuperview];
    [[self.view viewWithTag:309] removeFromSuperview];
    [[self.view viewWithTag:310] removeFromSuperview];
    [[self.view viewWithTag:311] removeFromSuperview];
    
    int buttonSize;
   
    NSString *searchDate;
    if(!self.date){
        searchDate = [Math getCurrentDate];
    }else{
     
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        searchDate = [dateFormat stringFromDate:self.date];
    }
    
    if(self.solarsystem.mars.x){
        [_spinner stopAnimating];
        
        self.star = self.solarsystem.sun;
        self.mercury = self.solarsystem.mercury;
        self.venus = self.solarsystem.venus;
        self.earth = self.solarsystem.earth;
        self.moon = self.solarsystem.moon;
        self.mars = self.solarsystem.mars;
        self.jupiter = self.solarsystem.jupiter;
        self.saturn = self.solarsystem.saturn;
        self.uranus = self.solarsystem.uranus;
        self.neptune = self.solarsystem.neptune;
        self.pluto = self.solarsystem.pluto;
        
        NSArray *planets = @[self.star, self.mercury, self.venus, self.moon, self.mars, self.jupiter, self.saturn, self.uranus, self.neptune, self.pluto];
       
        //Get earth centered coordinates and quadrant
        for(Planet *p in planets){
            
            p.earthCenteredX = p.x - self.earth.x;
            p.earthCenteredY = p.y - self.earth.y;
            p.earthCenteredZ = p.z - self.earth.z;
            
            if(p.earthCenteredX > 0 && p.earthCenteredY > 0){
                p.earthCenteredQuadrant = 1;
                p.polarAngle = atan(p.earthCenteredY/p.earthCenteredX);
                
            }else if (p.earthCenteredX < 0 && p.earthCenteredY > 0){
                p.earthCenteredQuadrant = 2;
                p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + 3.141593);
               
            }else if (p.earthCenteredX < 0 && p.earthCenteredY < 0){
                p.earthCenteredQuadrant = 3;
                p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + 3.141593);
               
            }else{
                p.earthCenteredQuadrant = 4;
                p.polarAngle = (atan(p.earthCenteredY/p.earthCenteredX) + (2*3.141593));
            }
        }
        //rotate coordinates to put the sun at zero
        for(Planet *p in planets){
        
            if(p.polarAngle < self.star.polarAngle){
                double difference = self.star.polarAngle - p.polarAngle;
                p.polarAngle = 2 * (3.141593) - difference;
            }
            else if (p.polarAngle > self.star.polarAngle){
                p.polarAngle = p.polarAngle - self.star.polarAngle;
            }
        }
        self.star.polarAngle = 0;
        
        //self.title = searchDate;
    
        //CGRect viewRectT = [self.view bounds];
        //NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    
        double temp;
        double temp2;
        
        
        temp = (((self.mercury.polarAngle / (2 * 3.141593))*330) + 70);
        int mercuryY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int mercuryX = [Screen fitX:(int)temp2 View:(UIView *)self.view];
    
        UIButton *mercury = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)30 View:(UIView *)self.view];
        [mercury setFrame:CGRectMake(mercuryX, mercuryY, buttonSize, buttonSize)];
        mercury.tag = 301;
        UIImage *mercuryImage = [UIImage imageNamed:[PlanetInfo pictureArray][mercury.tag - 300]];
        [mercury setImage:mercuryImage forState:UIControlStateNormal];
        [self.view addSubview:mercury];
        [mercury addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];

    
        temp = (((self.venus.polarAngle / (2 * 3.141593))*330) + 70);
        int venusY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int venusX = [Screen fitX:(int)temp2 View:(UIView *)self.view];

        UIButton *venus = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)30 View:(UIView *)self.view];
        [venus setFrame:CGRectMake(venusX, venusY, buttonSize, buttonSize)];
        venus.tag = 302;
        UIImage *venusImage = [UIImage imageNamed:[PlanetInfo pictureArray][venus.tag - 300]];
        [venus setImage:venusImage forState:UIControlStateNormal];
        [self.view addSubview:venus];
        [venus addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
        
        temp = (((self.moon.polarAngle / (2 * 3.141593))*330) + 70);
        int moonY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int moonX = [Screen fitX:(int)temp2 View:(UIView *)self.view];

        
        UIButton *moon = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)30 View:(UIView *)self.view];
        [moon setFrame:CGRectMake(moonX, moonY, buttonSize, buttonSize)];
        moon.tag = 304;
        UIImage *moonImage = [UIImage imageNamed:[PlanetInfo pictureArray][moon.tag - 300]];
        [moon setImage:moonImage forState:UIControlStateNormal];
        [self.view addSubview:moon];
        [moon addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
        
        temp = (((self.mars.polarAngle / (2 * 3.141593))*330) + 70);
        int marsY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int marsX = [Screen fitX:(int)temp2 View:(UIView *)self.view];
    
        UIButton *mars = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)30 View:(UIView *)self.view];
        [mars setFrame:CGRectMake(marsX, marsY, buttonSize, buttonSize)];
        mars.tag = 305;
        UIImage *marsImage = [UIImage imageNamed:[PlanetInfo pictureArray][mars.tag - 300]];
        [mars setImage:marsImage forState:UIControlStateNormal];
        [self.view addSubview:mars];
        [mars addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
    
        temp = (((self.jupiter.polarAngle / (2 * 3.141593))*330) + 70);
        int jupiterY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int jupiterX = [Screen fitX:(int)temp2 View:(UIView *)self.view];
    
        UIButton *jupiter = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)45 View:(UIView *)self.view];
        [jupiter setFrame:CGRectMake(jupiterX, jupiterY, buttonSize, buttonSize)];
        jupiter.tag = 307;
        UIImage *jupiterImage = [UIImage imageNamed:[PlanetInfo pictureArray][jupiter.tag - 300]];
        [jupiter setImage:jupiterImage forState:UIControlStateNormal];
        [self.view addSubview:jupiter];
        [jupiter addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
    
        temp = (((self.saturn.polarAngle / (2 * 3.141593))*330) + 70);
        int saturnY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int saturnX = [Screen fitX:(int)temp2 View:(UIView *)self.view];

        UIButton *saturn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)40 View:(UIView *)self.view];
        [saturn setFrame:CGRectMake(saturnX, saturnY, buttonSize, buttonSize)];
        saturn.tag = 308;
        UIImage *saturnImage = [UIImage imageNamed:[PlanetInfo pictureArray][saturn.tag - 300]];
        [saturn setImage:saturnImage forState:UIControlStateNormal];
        [self.view addSubview:saturn];
        [saturn addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
        temp = (((self.uranus.polarAngle / (2 * 3.141593))*330) + 70);
        int uranusY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int uranusX = [Screen fitX:(int)temp2 View:(UIView *)self.view];

        UIButton *uranus = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)40 View:(UIView *)self.view];
        [uranus setFrame:CGRectMake(uranusX, uranusY, buttonSize, buttonSize)];
        uranus.tag = 309;
        UIImage *uranusImage = [UIImage imageNamed:[PlanetInfo pictureArray][uranus.tag - 300]];
        [uranus setImage:uranusImage forState:UIControlStateNormal];
        [self.view addSubview:uranus];
        [uranus addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
    
        temp = (((self.neptune.polarAngle / (2 * 3.141593))*330) + 70);
        int neptuneY = [Screen fitY:(int)temp View:(UIView *)self.view];

        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int neptuneX = [Screen fitX:(int)temp2 View:(UIView *)self.view];
        
        UIButton *neptune = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)40 View:(UIView *)self.view];
        [neptune setFrame:CGRectMake(neptuneX, neptuneY, buttonSize, buttonSize)];
        neptune.tag = 310;
        UIImage *neptuneImage = [UIImage imageNamed:[PlanetInfo pictureArray][neptune.tag - 300]];
        [neptune setImage:neptuneImage forState:UIControlStateNormal];
        [self.view addSubview:neptune];
        [neptune addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
        
        
        temp = (((self.pluto.polarAngle / (2 * 3.141593))*330) + 70);
        int plutoY = [Screen fitY:(int)temp View:(UIView *)self.view];
        
        temp2 = (.005*(temp - 220)*(temp - 220) +150);
        int plutoX = [Screen fitX:(int)temp2 View:(UIView *)self.view];
        
        UIButton *pluto = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSize = [Screen sizePlanetButton:(int)30 View:(UIView *)self.view];
        [pluto setFrame:CGRectMake(plutoX, plutoY, buttonSize, buttonSize)];
        pluto.tag = 311;
        UIImage *plutoImage = [UIImage imageNamed:[PlanetInfo pictureArray][pluto.tag - 300]];
        [pluto setImage:plutoImage forState:UIControlStateNormal];
        [self.view addSubview:pluto];
        [pluto addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
    }
   
    buttonSize = [Screen sizePlanetButton:(int)100 View:(UIView *)self.view];

    
    //place sun
    CGRect viewRectT = [self.view bounds];
    
    int sun1XPos = viewRectT.size.width - (.2 * buttonSize);
    int sun2XPos = viewRectT.size.width - (.2 * buttonSize);
    int sun1YPos = 0;
    int sun2YPos = viewRectT.size.height - (buttonSize);
    
    UIButton *sun1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [sun1 setFrame:CGRectMake(sun1XPos, sun1YPos, buttonSize, buttonSize)];
    sun1.tag = 300;
    
    UIImage *sunImage = [UIImage imageNamed:[PlanetInfo pictureArray][sun1.tag - 300]];
    [sun1 setImage:sunImage forState:UIControlStateNormal];
    [self.view addSubview:sun1];
    [sun1 addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sun2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [sun2 setFrame:CGRectMake(sun2XPos, sun2YPos, buttonSize, buttonSize)];
    sun2.tag = 300;
    [sun2 setImage:sunImage forState:UIControlStateNormal];
    [self.view addSubview:sun2];
    [sun2 addTarget:self action:@selector(viewPlanet:)forControlEvents:UIControlEventTouchUpInside];
    
    int fontSize =[Screen sizeFont:(int)20 View:(UIView *)self.view];
    
    int labelYAxis = [Screen fitY:(int)55 View:(UIView *)self.view];
    UILabel *noon1Label = [[UILabel alloc] initWithFrame:CGRectMake(20,labelYAxis,280,40)];
    noon1Label.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    noon1Label.textColor = [UIColor whiteColor];
    noon1Label.text = [Numbers formatTime:@"12:00"];
    [self.view addSubview:noon1Label];

    
    labelYAxis = [Screen fitY:(int)395 View:(UIView *)self.view];
    UILabel *noon2Label = [[UILabel alloc] initWithFrame:CGRectMake(20,labelYAxis,280,40)];
    noon2Label.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    noon2Label.textColor = [UIColor whiteColor];
    noon2Label.text = [Numbers formatTime:@"12:00"];
    [self.view addSubview:noon2Label];

    
    labelYAxis = [Screen fitY:(int)225 View:(UIView *)self.view];
    UILabel *midnightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,labelYAxis,280,40)];
    midnightLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    midnightLabel.textColor = [UIColor whiteColor];
    midnightLabel.text = NSLocalizedString(@"Midnight", nil);
    [self.view addSubview:midnightLabel];

    
    labelYAxis = [Screen fitY:(int)140 View:(UIView *)self.view];
    UILabel *sixPLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,labelYAxis,280,40)];
    sixPLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    sixPLabel.textColor = [UIColor whiteColor];
    sixPLabel.text = [Numbers formatTime:@"6:00"];
    [self.view addSubview:sixPLabel];
    
    
    labelYAxis = [Screen fitY:(int)310 View:(UIView *)self.view];
    UILabel *sixALabel = [[UILabel alloc] initWithFrame:CGRectMake(20,labelYAxis,280,40)];
    sixALabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    sixALabel.textColor = [UIColor whiteColor];
    sixALabel.text = [Numbers formatTime:@"6:00"];
    [self.view addSubview:sixALabel];
    
    fontSize =[Screen sizeFont:(int)10 View:(UIView *)self.view];
    
    UILabel *eveningLabel = [[UILabel alloc] initWithFrame:CGRectMake(2,[Screen fitX:(int)90 View:(UIView *)self.view],[Screen fitX:(int)8 View:(UIView *)self.view],[Screen fitY:(int)150 View:(UIView *)self.view])];
    eveningLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    eveningLabel.textColor = [UIColor whiteColor];
    eveningLabel.numberOfLines = 0;
    eveningLabel.lineBreakMode = NSLineBreakByCharWrapping;
    eveningLabel.textAlignment = NSTextAlignmentCenter;
    eveningLabel.text = NSLocalizedString(@"e v e n i n g", nil);
    [self.view addSubview:eveningLabel];
    
    UILabel *morningLabel = [[UILabel alloc] initWithFrame:CGRectMake(2,[Screen fitY:(int)235 View:(UIView *)self.view],[Screen fitY:(int)8 View:(UIView *)self.view],[Screen fitY:(int)150 View:(UIView *)self.view])];
    morningLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize-1];
    morningLabel.textColor = [UIColor whiteColor];
    morningLabel.numberOfLines = 0;
    morningLabel.lineBreakMode = NSLineBreakByCharWrapping;
    morningLabel.textAlignment = NSTextAlignmentCenter;
    morningLabel.text = NSLocalizedString(@"m o r n i n g", nil);
    [self.view addSubview:morningLabel];



}

- (void) viewPlanet:(UIButton* )sender
{
    
    PlanetViewController *planetVC = [[PlanetViewController alloc] init];
    planetVC.bodyNumber = sender.tag;
    [self.navigationController pushViewController:planetVC animated:YES];


}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.solarsystem.mars.x) {
        [super viewWillAppear:animated];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(120, 230, 50, 50);
        activityIndicator.center = self.view.center;
        [self.view addSubview: activityIndicator];
        [activityIndicator startAnimating];
        
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
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    if([URLcheck canConnectTo:@"http://www.astro-phys.com"]){

        self.solarsystem = [[SolarSystem alloc] initSolarSystemFor:(NSDate *)self.date];
    
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
