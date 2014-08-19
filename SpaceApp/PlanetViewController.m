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

@interface PlanetViewController ()

@end

@implementation PlanetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = self.title;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.bodyNumber){
        [self loadSelfInformationFromTag:(int)self.bodyNumber];
    }
    
   
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Find times"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(risePressed)];
    
    self.navigationItem.rightBarButtonItem = rightButton;

	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.planetPicture]];
    imageView.frame = CGRectMake(10,10,300,300);
    [self.view addSubview:imageView];
    
    self.date = [NSDate date];
    self.currentPlanet = [[Planet alloc]initPlanet:(NSString *)[self.planetName lowercaseString] Date:(NSDate *)self.date];
    self.earth = [[Planet alloc]initPlanet:@"earth" Date:(NSDate *)self.date];
    self.sun = [[Planet alloc]initPlanet:@"sun" Date:(NSDate *)self.date];

    
    [self fillSplashView];
    
    }
- (id) loadSelfInformationFromTag:(int)tag
{
    self.planetPicture = [PlanetInfo pictureArray][tag - 300];
    self.planetName = [[PlanetInfo bodyArray][tag - 300] lowercaseString];
    

    
    return self;
}

- (void)fillSplashView
{
    
    [[self.view viewWithTag:200] removeFromSuperview];
    [[self.view viewWithTag:201] removeFromSuperview];
    [[self.view viewWithTag:202] removeFromSuperview];
    [[self.view viewWithTag:203] removeFromSuperview];
    [[self.view viewWithTag:204] removeFromSuperview];
    
    if(self.currentPlanet.x && self.currentPlanet.y && self.currentPlanet.z && self.earth.x && self.earth.y && self.earth.z){
    
    NSString *distance = [Math calculateDistanceX1:self.earth.x Y1:self.earth.y Z1:self.earth.z X2:self.currentPlanet.x Y2:self.currentPlanet.y Z2:self.currentPlanet.z];
        
        
        
        self.distance = distance;
        
         NSLog(@"Distance: %@", distance);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,280,280,80)];
        UILabel *distanceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(12,320,280,80)];
        UILabel *distanceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(12,340,280,40)];
        UILabel *zenithLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,360,280,80)];
        UILabel *zenithLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(12,380,280,80)];
        
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = 200;
        titleLabel.text = [NSString stringWithFormat:@"%@   on   %@:", [self.currentPlanet.name uppercaseString], [Math formatDate:self.date]];
        [self.view addSubview:titleLabel];
        
        
        distanceLabel1.font = [UIFont fontWithName:@"Helvetica" size:15];
        distanceLabel1.textColor = [UIColor whiteColor];
        distanceLabel1.tag = 201;
        distanceLabel1.text = [NSString stringWithFormat:@"%@ kilometers from Earth", distance];
        [self.view addSubview:distanceLabel1];
        
        distanceLabel2.font = [UIFont fontWithName:@"Helvetica" size:15];
        distanceLabel2.textColor = [UIColor whiteColor];
        distanceLabel2.tag = 202;
        distanceLabel2.text = [NSString stringWithFormat:@"kilometers from Earth"];
        //[self.view addSubview:distanceLabel2];
        
        
        
        if(![self.currentPlanet.name isEqualToString:@"earth"] && ![self.currentPlanet.name isEqualToString:@"sun"])
        {
     
        
        //double zenith = round([Math findZenithPlanet:(Planet *)self.currentPlanet Earth:(Planet *)self.earth Sun:(Planet *)self.sun]);
            //NSLog(@"ZENITH: %f", zenith);
        self.currentPlanet = ([Math findZenithPlanet:(Planet *)self.currentPlanet Earth:(Planet *)self.earth Sun:(Planet *)self.sun]);
            
        int hour = (int)self.currentPlanet.zenith;
        
        zenithLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        zenithLabel.textColor = [UIColor whiteColor];
        zenithLabel.lineBreakMode = NSLineBreakByWordWrapping;
            zenithLabel.tag = 203;
            zenithLabel.text = @"Highest point in the sky:";
            [self.view addSubview:zenithLabel];

        zenithLabel2.font = [UIFont fontWithName:@"Helvetica" size:15];
        zenithLabel2.textColor = [UIColor whiteColor];
        zenithLabel2.textAlignment = NSTextAlignmentCenter;
            zenithLabel2.tag = 204;
            zenithLabel2.text = [NSString stringWithFormat:@"around %d:00. (Astronomical time)", hour];

        [self.view addSubview:zenithLabel2];
        }
    }
    
//    UIButton *riseTime = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    riseTime.frame = CGRectMake(12,80,360,30);
//    riseTime.backgroundColor =[UIColor yellowColor];
//    [riseTime setTitle:@"When to see it?" forState:UIControlStateNormal];
//    [self.view addSubview:riseTime];
//    [riseTime addTarget:self action:@selector(risePressed)forControlEvents:UIControlEventTouchUpInside];
}

- (void) risePressed
{
    PlanetRiseViewController *planetRiseVC = [[PlanetRiseViewController alloc] init];
    planetRiseVC.planet = self.currentPlanet;
    planetRiseVC.title = self.title;
    planetRiseVC.earth = self.earth;
    planetRiseVC.star = self.sun;
    //planetRiseVC.planetName = self.planets[indexPath.row];
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
