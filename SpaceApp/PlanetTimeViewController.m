//
//  PlanetTimeViewController.m
//  Space
//
//  Created by Alana Hosick on 2/2/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "PlanetTimeViewController.h"
#import "Math.h"
#import "Sun.h"
#import "Parser.h"
#import "Planet.h"
#import "RiseSetStrings.h"
#import "PlanetInfo.h"

@interface PlanetTimeViewController ()

@end

@implementation PlanetTimeViewController

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
    
    CGRect rect = [self.view bounds];
    NSArray *backgroundArray;
    if(rect.size.height > 1000){
        backgroundArray = [PlanetInfo NASALargePictureArray];
    }else{
        backgroundArray = [PlanetInfo NASAPictureArray];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundArray[[PlanetInfo returnPlanetIndex:self.planet.name]]]];
    
    self.sun = [[Sun alloc]initSunLat:(long double)self.latitude Long:(long double)self.longitude Date:(NSDate *)self.date DST:(BOOL)self.dst];
    self.star = [[Planet alloc] initPlanet:(NSString *)@"sun" Date:(NSDate *)self.date];
    self.earth = [[Planet alloc] initPlanet:(NSString *)@"earth" Date:(NSDate *)self.date];
    self.planet = [[Planet alloc] initPlanet:(NSString *)self.planet.name Date:(NSDate *)self.date];
	[self fillSplashView];
}

- (void) fillSplashView

{
    if(self.earth.x && self.star.x && self.planet.x){
        NSString *sunriseResponseString = self.sun.responseString;
        
        self.sunrise = [Parser getSecondsFromStringForKey:(NSString *)@"sunrise" inString:(NSString *)sunriseResponseString];
        self.sunset = [Parser getSecondsFromStringForKey:(NSString *)@"sunset" inString:(NSString *)sunriseResponseString];
        
        if([self.planet.name isEqualToString:@"earth"]){
            NSLog(@"finding rise time for earth");
        }else if ([self.planet.name isEqualToString:@"sun"]){
            self.planet.polarAngle = 0;
        }else{
        self.planet.polarAngle = [Math findPolarAnglePlanet:(Planet *)self.planet Earth:(Planet *)self.earth Sun:(Planet *)self.star];
        NSLog(@"***************   planet polar angle: %f", self.planet.polarAngle);
        
        }
        double riseSeconds = [Math riseSecondsPlanet:(Planet *)self.planet Sunrise:(double)self.sunrise];
        NSLog(@"***************   %@ seconds: %f", self.planet.name, riseSeconds);
        
        self.riseTime = [Math timeFromSeconds:(long)riseSeconds];
        NSLog(@" ******************** %@ RISE TIME: %@ : %@ : %@ ************************", self.planet.name, self.riseTime[0],self.riseTime[1],self.riseTime[2]);
        
        double setSeconds = [Math setSecondsPlanet:(Planet *)self.planet Sunset:(double)self.sunset];
        NSLog(@"***************   %@ seconds: %f", self.planet.name, setSeconds);
        
        self.setTime = [Math timeFromSeconds:(long)setSeconds];
        NSLog(@" ******************** %@ SET TIME: %@ : %@ : %@ ************************", self.planet.name, self.setTime[0],self.setTime[1],self.setTime[2]);
        
        self.zenithTime = [Math timeFromSeconds:((riseSeconds +setSeconds)/2)];
        NSLog(@" ******************** %@ zenith TIME: %@ : %@ : %@ ************************", self.planet.name, self.zenithTime[0],self.zenithTime[1],self.zenithTime[2]);

        
        //[self createString];
    }else{
        NSLog(@"***************   else ");
        self.planet.x = 0;
    }
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,70,280,80)];
    int textY;
    int textX;
    int height;
    CGRect rect = [self.view bounds];
    if(rect.size.height > 1000){
        textY = 900;
        textX = 765;
    }
    else if(rect.size.height > 560){
        textY = 400;
        textX = 315;
    }else{
        textY = 320;
        textX = 315;
    }
   
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(5,textY,textX,200)];
    text.text = [self createStringPlanet:(Planet *)self.planet Date:(NSDate *)self.date RiseHour:(NSString *)self.riseTime[0] ZenithHour:(NSString *) self.zenithTime[0] SetHour:(NSString *)self.setTime[0]];
    text.backgroundColor = [UIColor blackColor];
    text.textColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:text];
    
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.tag = 200;
    titleLabel.text = [NSString stringWithFormat:@"%@   on   %@:", [self.planet.name uppercaseString], [Math formatDate:self.date]];
    [self.view addSubview:titleLabel];
    
//    
//    distanceLabel1.font = [UIFont fontWithName:@"Helvetica" size:15];
//    distanceLabel1.textColor = [UIColor whiteColor];
//    distanceLabel1.tag = 201;
//    distanceLabel1.text = [NSString stringWithFormat:@"text"];
//    [self.view addSubview:distanceLabel1];
    
//    distanceLabel2.font = [UIFont fontWithName:@"Helvetica" size:15];
//    distanceLabel2.textColor = [UIColor whiteColor];
//    distanceLabel2.tag = 202;
//    distanceLabel2.text = [NSString stringWithFormat:@"text"];
//    //[self.view addSubview:distanceLabel2];
    

}

- (NSString *) createStringPlanet:(Planet *)planet Date:(NSDate *)date RiseHour:(NSString *)riseHour ZenithHour:(NSString *)zenithHour SetHour:(NSString *)setHour
{
    NSString *string;
    if ([planet.name isEqualToString:@"sun"]){
        //string = [NSString stringWithFormat:@"%@ %@ %@, and %@ %@.", planet.name, [RiseSetStrings riseTense:date], [RiseSetStrings timeOfDay:riseHour],  [RiseSetStrings setTense:date], [RiseSetStrings timeOfDay:setHour]];
        string = @"The sun will rise in the morning and set in the evening.";
    }
    else if (planet.x == 0){
        string = @"no location data is available for that body at this time";
    }
    else if ([planet.name isEqualToString:@"earth"]){
        string = @"The Earth can be seen most of the time.  Usually you look down.";
    }else{
    string  = [NSString stringWithFormat:@"%@ %@ the same path across the sky as the sun.  %@ %@ %@, and %@ %@.", planet.name, [RiseSetStrings takeTense:date], planet.name, [RiseSetStrings riseTense:date], [RiseSetStrings timeOfDay:riseHour], [RiseSetStrings setTense:date], [RiseSetStrings timeOfDay:setHour]];
    }
    return string;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.sun.responseString || !self.star.x  || !self.planet.x || !self.earth.x) {
        [super viewWillAppear:animated];
        //NSLog(@"%@",self.sun.responseString );
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillSplashView) name:@"initWithJSONFinishedLoading" object:nil];
    }else{
        NSLog(@"waiting for response");
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
