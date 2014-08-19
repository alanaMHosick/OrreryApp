//
//  SettingsViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/14/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "SettingsViewController.h"
#import "CuriosityViewController.h"
#import "CreditsviewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

NSString *distanceUnits;
NSString *temperatureUnits;
NSString *distanceAbrev;
NSString *temperatureAbrev;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Settings", nil);
        self.view.backgroundColor = [UIColor blackColor];
        //if(!distanceUnits){
        distanceUnits = @"kilometers";
       // }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fillSplashView];
	// Do any additional setup after loading the view.
}

- (void)fillSplashView
{
    CGRect rect = [self.view bounds];
   
    self.dstLabelHeight = 50;
   
    self.width = rect.size.width;
    if (rect.size.height > 1000){
       
        self.y = 75;
        self.spacer = 80;
        self.labelHeight = 80;
        self.font = 30;
        self.leftMargin = 50;
        self.rightMargin = 100;
        self.buttonXposition = 400;
    }
    else if (rect.size.height > 560){
        self.y = 50;
        self.spacer = 45;
        self.labelHeight = 40;
        self.font = 14;
        self.leftMargin = 15;
        self.rightMargin = 40;
        self.buttonXposition = 200;
        
    }else{
        self.y = 25;
        self.spacer = 40;
        self.labelHeight = 40;
        self.font = 14;
        self.leftMargin = 15;
        self.rightMargin = 40;
        self.buttonXposition = 200;
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin, self.labelHeight)];
    titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:self.font * 2];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Settings", nil)];
    [self.view addSubview:titleLabel];
    self.y = self.y + self.spacer;
    self.y = self.y + (self.spacer * .5);
    
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin, self.labelHeight)];
    distanceLabel.font = [UIFont fontWithName:@"Verdana" size:self.font];
    distanceLabel.textColor = [UIColor whiteColor];
    distanceLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Choose the units for distance", nil)];
    [self.view addSubview:distanceLabel];
    self.y = self.y + self.spacer;
    //distance buttons
    //kilometers
    if(distanceUnits == nil){
    distanceUnits = @"kilometers";
    }
    NSLog(@"DISTANCE UNITS: %@", distanceUnits);
    UILabel *kilometersLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin-(3*self.rightMargin), self.labelHeight)];
    kilometersLabel.font = [UIFont fontWithName:@"Verdana" size:self.font];
    kilometersLabel.textColor = [UIColor whiteColor];
    //kilometersLabel.backgroundColor = [UIColor purpleColor];
    kilometersLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Kilometers", nil)];
    [self.view addSubview:kilometersLabel];

    self.radioButton1kilometers = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonXposition, self.y, self.labelHeight, self.labelHeight)];
    //self.radioButton1kilometers = [[UIButton alloc] initWithFrame:CGRectMake(550, self.y, 625, self.labelHeight)];

    self.radioButton1kilometers.tag = 3;
    if([distanceUnits isEqualToString:@"kilometers"]){
        self.radioButton1kilometers.selected = YES;
    }
    
    
    [self.radioButton1kilometers setImage:[UIImage imageNamed:@"bluebuttonOff.png"] forState:UIControlStateNormal];
    [self.radioButton1kilometers setImage:[UIImage imageNamed:@"bluebuttonOn.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.radioButton1kilometers];
    [self.radioButton1kilometers addTarget:self action:@selector(on_click_distance:)forControlEvents:UIControlEventTouchUpInside];
    
    
    self.y = self.y + self.spacer;
    
    //miles
    UILabel *milesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin, self.labelHeight)];
    milesLabel.font = [UIFont fontWithName:@"Verdana" size:self.font];
    milesLabel.textColor = [UIColor whiteColor];
    milesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Miles", nil)];
    [self.view addSubview:milesLabel];

    self.radioButton1miles = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonXposition, self.y, self.labelHeight, self.labelHeight)];
    self.radioButton1miles.tag = 4;
    [self.radioButton1miles setImage:[UIImage imageNamed:@"bluebuttonOff.png"] forState:UIControlStateNormal];
    [self.radioButton1miles setImage:[UIImage imageNamed:@"bluebuttonOn.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.radioButton1miles];
    [self.radioButton1miles addTarget:self action:@selector(on_click_distance:)forControlEvents:UIControlEventTouchUpInside];
    self.y = self.y + self.spacer;

    //lightminutes
    UILabel *lightminutesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin, self.labelHeight)];
    lightminutesLabel.font = [UIFont fontWithName:@"Verdana" size:self.font];
    lightminutesLabel.textColor = [UIColor whiteColor];
    lightminutesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Light Minutes", nil)];
    [self.view addSubview:lightminutesLabel];
    
    self.radioButton1lightminutes = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonXposition, self.y, self.labelHeight, self.labelHeight)];
    self.radioButton1lightminutes.tag = 5;
    [self.radioButton1lightminutes setImage:[UIImage imageNamed:@"bluebuttonOff.png"] forState:UIControlStateNormal];
    [self.radioButton1lightminutes setImage:[UIImage imageNamed:@"bluebuttonOn.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.radioButton1lightminutes];
    [self.radioButton1lightminutes addTarget:self action:@selector(on_click_distance:)forControlEvents:UIControlEventTouchUpInside];
    self.y = self.y + self.spacer;

   
    self.y = self.y + self.spacer;
    
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin, self.labelHeight)];
    temperatureLabel.font = [UIFont fontWithName:@"Verdana" size:self.font];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Choose the units for temperature", nil)];
    [self.view addSubview:temperatureLabel];
    self.y = self.y + self.spacer;
    
    //temperature buttons
    //Celsius
    if (temperatureUnits == nil){
    temperatureUnits = @"celsius";
    temperatureAbrev = @"C";
    }
    //self.y = y;
    NSLog(@"TEMPERATURE UNITS: %@", temperatureUnits);
    
    UILabel *celsiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin, self.labelHeight)];
    
    celsiusLabel.font = [UIFont fontWithName:@"Helvetica" size:self.font];
    celsiusLabel.textColor = [UIColor whiteColor];
    celsiusLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Celsius", nil)];
    [self.view addSubview:celsiusLabel];
    
    self.radioButton2celsius = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonXposition,self.y, self.labelHeight, self.labelHeight)];
    self.radioButton2celsius.tag = 0;
    if([temperatureUnits isEqualToString:@"celsius"]){
        self.radioButton2celsius.selected = YES;
    }else{
        self.radioButton2celsius.selected = NO;
        
    }
    [self.radioButton2celsius setImage:[UIImage imageNamed:@"bluebuttonOff.png"] forState:UIControlStateNormal];
    [self.radioButton2celsius setImage:[UIImage imageNamed:@"bluebuttonOn.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.radioButton2celsius];
    [self.radioButton2celsius addTarget:self action:@selector(on_click_temperature:)forControlEvents:UIControlEventTouchUpInside];
    self.y = self.y + self.spacer;
    
    //fahrenheit
    UILabel *fahrenheitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin,self.y, self.width - self.rightMargin,self.labelHeight)];
    fahrenheitLabel.font = [UIFont fontWithName:@"Helvetica" size:self.font];
    fahrenheitLabel.textColor = [UIColor whiteColor];
    fahrenheitLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Fahrenheit", nil)];
    [self.view addSubview:fahrenheitLabel];
    
    self.radioButton2fahrenheit = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonXposition,self.y, self.labelHeight, self.labelHeight)];
    self.radioButton2fahrenheit.tag = 1;
    if([temperatureUnits isEqualToString:@"fahrenheit"]){
        self.radioButton2fahrenheit.selected = YES;
    }else{
        self.radioButton2fahrenheit.selected = NO;
        
    }
    [self.radioButton2fahrenheit setImage:[UIImage imageNamed:@"bluebuttonOff.png"] forState:UIControlStateNormal];
    [self.radioButton2fahrenheit setImage:[UIImage imageNamed:@"bluebuttonOn.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.radioButton2fahrenheit];
    [self.radioButton2fahrenheit addTarget:self action:@selector(on_click_temperature:)forControlEvents:UIControlEventTouchUpInside];
    self.y = self.y + self.spacer;
    
    //kelvin
    UILabel *kelvinLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftMargin, self.y, self.width - self.rightMargin,self.labelHeight)];
    kelvinLabel.font = [UIFont fontWithName:@"Helvetica" size:self.font];
    kelvinLabel.textColor = [UIColor whiteColor];
    kelvinLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Kelvin", nil)];
    [self.view addSubview:kelvinLabel];
    
    self.radioButton2kelvin = [[UIButton alloc] initWithFrame:CGRectMake(self.buttonXposition, self.y, self.labelHeight, self.labelHeight)];
    self.radioButton2kelvin.tag = 2;
    if([temperatureUnits isEqualToString:@"kelvin"]){
        self.radioButton2kelvin.selected = YES;
    }else{
        self.radioButton2kelvin.selected = NO;
        
    }
    [self.radioButton2kelvin setImage:[UIImage imageNamed:@"bluebuttonOff.png"] forState:UIControlStateNormal];
    [self.radioButton2kelvin setImage:[UIImage imageNamed:@"bluebuttonOn.png"] forState:UIControlStateSelected];
    [self.view addSubview:self.radioButton2kelvin];
    [self.radioButton2kelvin addTarget:self action:@selector(on_click_temperature:)forControlEvents:UIControlEventTouchUpInside];
    self.y = self.y + self.spacer;
    
}
-(void)on_click_temperature:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    [button setSelected:!button.isSelected];
    
    if(button.isSelected)
    {
        if(button.tag == 0){
            temperatureUnits = @"celsius";
            temperatureAbrev = @"C";
            self.radioButton2fahrenheit.selected = NO;
            self.radioButton2kelvin.selected = NO;
            
        }else if(button.tag == 1){
            temperatureUnits = @"fahrenheit";
            temperatureAbrev = @"F";
            self.radioButton2celsius.selected = NO;
            self.radioButton2kelvin.selected = NO;
        }else{
            temperatureUnits = @"kelvin";
            temperatureAbrev = @"K";
            self.radioButton2fahrenheit.selected = NO;
            self.radioButton2celsius.selected = NO;
            
            
            
        }
    }
}

-(void)on_click_distance:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    [button setSelected:!button.isSelected];
    
    if(button.isSelected)
    {
        if(button.tag == 3){
            distanceUnits = @"kilometers";
            self.radioButton1miles.selected = NO;
            self.radioButton1lightminutes.selected = NO;
            
        }else if(button.tag == 4){
            distanceUnits = @"miles";
            self.radioButton1kilometers.selected = NO;
            self.radioButton1lightminutes.selected = NO;
        }else{
            distanceUnits = @"light minutes";
            self.radioButton1kilometers.selected = NO;
            self.radioButton1miles.selected = NO;
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
