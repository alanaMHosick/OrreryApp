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
#import "URLcheck.h"
#import "RADEC.h"
#import "UserLocation.h"
#import "ImageViewController.h"
#import "SolarEclipseViewController.h"
#import "LunarEclipseViewController.h"
#import "Numbers.h"
#import "Colors.h"
#import "SettingsViewController.h"


@interface PlanetTimeViewController ()

@end

@implementation PlanetTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    NSLog(@"planetTime");
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = [self.view bounds];
    
    UIColor *buttonColor = [UIColor clearColor];
    
    if([self.planet.name isEqualToString:(@"sun")]){
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                        initWithTitle:NSLocalizedString(@"Eclipse",nil)
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(solarEclipse:)];
        rightButton.tintColor = [Colors barGreen] ;
        self.navigationItem.rightBarButtonItem = rightButton;

    }
    
    if([self.planet.name isEqualToString:(@"moon")]){
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                        initWithTitle:NSLocalizedString(@"Eclipse",nil)
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(lunarEclipse:)];
        rightButton.tintColor = [Colors barGreen] ;
        self.navigationItem.rightBarButtonItem = rightButton;
        
    }

    
    
    
    UIButton *imageViewer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    imageViewer.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    
    imageViewer .backgroundColor = buttonColor;
    [self.view addSubview:imageViewer ];
    [imageViewer  addTarget:self action:@selector(imageViewer)forControlEvents:UIControlEventTouchUpInside];

    NSArray *backgroundArray;
    if(rect.size.height > 1000){
        backgroundArray = [PlanetInfo NASAPictureArray];
    }else{
        backgroundArray = [PlanetInfo NASAPictureArraySm];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:backgroundArray[[PlanetInfo returnPlanetIndex:self.planet.name]]]];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    if([URLcheck canConnectTo:@"http://www.astro-phys.com"]) {//&& [URLcheck canConnectTo:@"http://www.google.com"]){
    
    self.sun = [[Sun alloc]initSunLat:(long double)self.latitude Long:(long double)self.longitude Date:(NSDate *)self.date DST:(BOOL)self.dst];
    self.star = [[Planet alloc] initPlanet:(NSString *)@"sun" Date:(NSDate *)self.date];
    self.earth = [[Planet alloc] initPlanet:(NSString *)@"earth" Date:(NSDate *)self.date];
    self.planet = [[Planet alloc] initPlanet:(NSString *)self.planet.name Date:(NSDate *)self.date];
    }
	[self fillSplashView];
}

- (void) fillSplashView

{
    //if(self.earth.x && self.star.x && self.planet.x){
    NSLog(@"self.planet.x %f", self.planet.x);
    if(self.planet.x){
        [_spinner stopAnimating];
        NSString *sunriseResponseString = self.sun.responseString;
        
        self.sunrise = [Parser getSecondsFromStringForKey:(NSString *)@"sunrise" inString:(NSString *)sunriseResponseString];
        self.sunset = [Parser getSecondsFromStringForKey:(NSString *)@"sunset" inString:(NSString *)sunriseResponseString];
        
        if([self.planet.name isEqualToString:@"earth"]){
           
        }else if ([self.planet.name isEqualToString:@"sun"]){
            self.planet.polarAngle = 0;
        }else{
        self.planet.polarAngle = [Math findPolarAnglePlanet:(Planet *)self.planet Earth:(Planet *)self.earth Sun:(Planet *)self.star];
       // NSLog(@"***************   planet polar angle: %f", self.planet.polarAngle);
        
        }
        double riseSeconds = [Math riseSecondsPlanet:(Planet *)self.planet Sunrise:(double)self.sunrise];
       // NSLog(@"***************   %@ seconds: %f", self.planet.name, riseSeconds);
        
        self.riseTime = [Math timeFromSeconds:(long)riseSeconds];
      //  NSLog(@" ******************** %@ RISE TIME: %@ : %@ : %@ ************************", self.planet.name, self.riseTime[0],self.riseTime[1],self.riseTime[2]);
        
        double setSeconds = [Math setSecondsPlanet:(Planet *)self.planet Sunset:(double)self.sunset];
      //  NSLog(@"***************   %@ seconds: %f", self.planet.name, setSeconds);
        
        self.setTime = [Math timeFromSeconds:(long)setSeconds];
      //  NSLog(@" ******************** %@ SET TIME: %@ : %@ : %@ ************************", self.planet.name, self.setTime[0],self.setTime[1],self.setTime[2]);
        
        self.zenithTime = [Math timeFromSeconds:((riseSeconds +setSeconds)/2)];
      //  NSLog(@" ******************** %@ zenith TIME: %@ : %@ : %@ ************************", self.planet.name, self.zenithTime[0],self.zenithTime[1],self.zenithTime[2]);

       self.planet = [RADEC riseSet:(Planet *)self.planet Earth:(Planet *)self.earth Star:(Planet *)self.star Longitude:(double)self.longitude Latitude:(double)self.latitude Date:(NSDate *)self.date  Timezone:(int)userTimezone Elevation:(double)userElevation];
       
    }else{
        NSLog(@"***************   else ");
        self.planet.x = 0;
    }
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,50,280,80)];
    
    UIColor *labelColor = [UIColor darkGrayColor];
    UIColor *borderColor = [UIColor grayColor];
    UIColor *highlight = [UIColor lightGrayColor];
    UIImage *riseCover;
    
    int textY;
    int textX;
    CGRect rect = [self.view bounds];
    if(rect.size.height > 1000){
        textY = 770;
        textX = 765;
        riseCover = [UIImage imageNamed:(@"riseCover3.png")];
    }
    else if(rect.size.height > 560){
        textY = 320;
        textX = 315;
        riseCover = [UIImage imageNamed:(@"riseCover.png")];
    }else{
        textY = 235;
        textX = 315;
        riseCover = [UIImage imageNamed:(@"riseCover.png")];
    }
    int halfscreen = rect.size.width/2;
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(5,textY,textX,50)];
    text.text = [self createStringPlanet:(Planet *)self.planet Date:(NSDate *)self.date RiseHour:(NSString *)self.riseTime[0] ZenithHour:(NSString *) self.zenithTime[0] SetHour:(NSString *)self.setTime[0]];
    text.backgroundColor = [UIColor blackColor];
    text.textColor = [UIColor whiteColor];
    text.font = [UIFont fontWithName:@"Verdana" size:18];
    //[self.view addSubview:text];
    
    titleLabel.font = [UIFont fontWithName:@"Verdana" size:16];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.tag = 200;
    titleLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ on %@:", nil), NSLocalizedString(self.planet.name, nil), [Numbers formatDate:[Math formatDate:self.date]]];
    [self.view addSubview:titleLabel];
    
    if(![self.planet.name isEqualToString:@"earth"]){
    
    
    textY = textY + 50;
        
    
        UILabel *gradient1 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        gradient1.backgroundColor = [UIColor lightGrayColor];
       
        [self.view addSubview:gradient1];
        
        textY = textY + 1;
        
        UILabel *gradient2 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,3)];
        gradient2.backgroundColor = [UIColor darkGrayColor];
            [self.view addSubview:gradient2];
        
        textY = textY + 3;
        
        int bottomOfAbove = textY;
        
        
        ///////////////  vertical edges  /////////////////
        
        
        UILabel *leftGradient2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0,3,rect.size.height)];
        leftGradient2.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:leftGradient2];
        
        UILabel *leftGradient1 = [[UILabel alloc] initWithFrame:CGRectMake(3,0,1,textY-3)];
        leftGradient1.backgroundColor = highlight;
        
        [self.view addSubview:leftGradient1];

        
        
        
    UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,30)];
    heading.text = NSLocalizedString(@"Approximate Times", nil);
    heading.backgroundColor = [UIColor blackColor];
    heading.textColor = [UIColor whiteColor];
    heading.textAlignment = NSTextAlignmentCenter;
    heading.font = [UIFont fontWithName:@"Verdana" size:15];
    [self.view addSubview:heading];
    
        if(rect.size.height > 1000){
           
            textX = 765;
        }else{
    textX = 230;
        }
    textY = textY + 30;
        
        //////////////// gradient  /////////////////////
        
        UILabel *gradient3 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        gradient3.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView *riseCover1 = [[UIImageView alloc] initWithImage:riseCover];
        [riseCover1 setFrame:CGRectMake(3,textY+3,rect.size.width - 3,20)];

        
        
        
        
        
        [self.view addSubview:gradient3];
        
        textY = textY + 1;
        
        UILabel *gradient4 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,2)];
        gradient4.backgroundColor = borderColor;
        [self.view addSubview:gradient4];
        
        textY = textY + 2;
        
       // if(self.planet.riseTime){
        
    UILabel *rise = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,halfscreen,20)];
    rise.text = NSLocalizedString(@"  Rise", nil);
        rise.backgroundColor = labelColor;
    rise.textColor = [UIColor whiteColor];
    rise.font = [UIFont fontWithName:@"Verdana" size:10];
        rise.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:rise];

    UILabel *riseValue = [[UILabel alloc] initWithFrame:CGRectMake(halfscreen,textY,textX,20)];
        
        riseValue.text = [NSString stringWithFormat:@"    %@",[Numbers formatTime:self.planet.riseTime]];
       
        riseValue.backgroundColor = labelColor;
    riseValue.textColor = [UIColor whiteColor];
    riseValue.textAlignment = NSTextAlignmentLeft;
    riseValue.font = [UIFont fontWithName:@"Verdana" size:10];
    [self.view addSubview:riseValue];
        
        ///////////////  vertical edges  /////////////////
        
       

        
        
        UILabel *leftGradient4 = [[UILabel alloc] initWithFrame:CGRectMake(2,textY,1,textY-3)];
        leftGradient4.backgroundColor = [UIColor lightGrayColor];
        
        
        
        bottomOfAbove = textY;

    
    textY = textY + 20;
        
        //horizontal highlight
        UILabel *gradient5Highlight = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        gradient5Highlight.backgroundColor = highlight;
        [self.view addSubview:gradient5Highlight];
        
        UIImageView *riseCover2 = [[UIImageView alloc] initWithImage:riseCover];
        [riseCover2 setFrame:CGRectMake(3,textY+3,rect.size.width - 3,20)];

        textY++;
        
        //vertical highlight
        UILabel *gradient5VerticalHighlight = [[UILabel alloc] initWithFrame:CGRectMake(2,bottomOfAbove,1,textY+2)];
        gradient5VerticalHighlight.backgroundColor = highlight;
        [self.view addSubview:gradient5VerticalHighlight];
        
        UILabel *gradient5 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,2)];
        gradient5.backgroundColor = borderColor;
        [self.view addSubview:gradient5];
        
        UILabel *gradientVertical5 = [[UILabel alloc] initWithFrame:CGRectMake(0,bottomOfAbove,2,textY+2)];
        gradientVertical5.backgroundColor = borderColor;
        [self.view addSubview:gradientVertical5];
        
        textY = textY + 2;
        bottomOfAbove = textY;
        
        

    UILabel *transit = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,halfscreen,20)];
    transit.text = NSLocalizedString(@"  Transit", nil);
        transit.backgroundColor = labelColor;
    transit.textColor = [UIColor whiteColor];
    transit.font = [UIFont fontWithName:@"Verdana" size:10];
        transit.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:transit];
        
    UILabel *transitValue = [[UILabel alloc] initWithFrame:CGRectMake(halfscreen,textY,textX,20)];
      
    transitValue.text = [NSString stringWithFormat:@"    %@",[Numbers formatTime:self.planet.transitTime]];
               transitValue.backgroundColor = labelColor;
    transitValue.textColor = [UIColor whiteColor];
    transitValue.textAlignment = NSTextAlignmentLeft;
    transitValue.font = [UIFont fontWithName:@"Verdana" size:10];
    [self.view addSubview:transitValue];
    
    textY = textY + 20;
       
        
        //horizontal highlight
        UILabel *gradient6Highlight = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        gradient6Highlight.backgroundColor = highlight;
        [self.view addSubview:gradient6Highlight];
        
        UIImageView *riseCover5 = [[UIImageView alloc] initWithImage:riseCover];
        [riseCover5 setFrame:CGRectMake(3,textY+3,rect.size.width - 3,20)];

        textY++;
        
        //vertical highlight
        UILabel *gradient6VerticalHighlight = [[UILabel alloc] initWithFrame:CGRectMake(2,bottomOfAbove,1,textY+2)];
        gradient6VerticalHighlight.backgroundColor = highlight;
        [self.view addSubview:gradient6VerticalHighlight];
        
        UILabel *gradient6 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,2)];
        gradient6.backgroundColor = borderColor;
        [self.view addSubview:gradient6];
        
        UILabel *gradientVertical6 = [[UILabel alloc] initWithFrame:CGRectMake(0,bottomOfAbove,2,textY+2)];
        gradientVertical6.backgroundColor = borderColor;
        [self.view addSubview:gradientVertical6];
        
        textY = textY + 2;
        bottomOfAbove = textY;

        
        
        
    UILabel *set = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,halfscreen,20)];
    set.text = NSLocalizedString(@"  Set", nil);
        set.backgroundColor = labelColor;
    set.textColor = [UIColor whiteColor];
    set.font = [UIFont fontWithName:@"Verdana" size:10];
        set.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:set];
    
    UILabel *setValue = [[UILabel alloc] initWithFrame:CGRectMake(halfscreen,textY,textX,20)];
    setValue.text = [NSString stringWithFormat:@"    %@",[Numbers formatTime:self.planet.setTime]];
        setValue.backgroundColor = labelColor;
    setValue.textColor = [UIColor whiteColor];
    setValue.textAlignment = NSTextAlignmentLeft;
    setValue.font = [UIFont fontWithName:@"Verdana" size:10];
    [self.view addSubview:setValue];
    
    textY = textY + 20;
        
        //horizontal highlight
        UILabel *gradient7Highlight = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        gradient7Highlight.backgroundColor = highlight;
        
        UIImageView *riseCover3 = [[UIImageView alloc] initWithImage:riseCover];
        [riseCover3 setFrame:CGRectMake(3,textY+3,rect.size.width - 3,20)];

        [self.view addSubview:gradient7Highlight];
        textY++;
        
        //vertical highlight
        UILabel *gradient7VerticalHighlight = [[UILabel alloc] initWithFrame:CGRectMake(2,bottomOfAbove,1,textY+2)];
        gradient7VerticalHighlight.backgroundColor = highlight;
        [self.view addSubview:gradient7VerticalHighlight];
        
        UILabel *gradient7 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,2)];
        gradient7.backgroundColor = borderColor;
        [self.view addSubview:gradient7];
        
        UILabel *gradientVertical7 = [[UILabel alloc] initWithFrame:CGRectMake(0,bottomOfAbove,2,textY+2)];
        gradientVertical7.backgroundColor = borderColor;
        [self.view addSubview:gradientVertical7];
        
        textY = textY + 2;
        bottomOfAbove = textY;

        
    UILabel *RA = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,halfscreen,20)];
    RA.text = NSLocalizedString(@"  Distance", nil);
        RA.backgroundColor = labelColor;
    RA.textColor = [UIColor whiteColor];
    RA.font = [UIFont fontWithName:@"Verdana" size:10];
        RA.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:RA];
    
    UILabel *RAValue = [[UILabel alloc] initWithFrame:CGRectMake(halfscreen,textY,textX,20)];
        //RAValue.text = [NSString stringWithFormat:@"    %@",[Numbers formatStr:[NSString stringWithFormat:@"%.2f",self.planet.RA]Digits:2 Decimals:2]];
        if ([self.distance isEqualToString:@"0"]){
            RAValue.text = @"Not Found";
            NSLog(@"%@", self.distance);
            
        }else{
        RAValue.text = [NSString stringWithFormat:NSLocalizedString(@"    %@ %@", nil),[Numbers formatStr:[Math userDistance:self.distance] Digits: 1 Decimals:2],NSLocalizedString(distanceUnits, nil)];
            NSLog(@"%@", self.distance);
        }
        RAValue.backgroundColor = labelColor;
    RAValue.textColor = [UIColor whiteColor];
    RAValue.textAlignment = NSTextAlignmentLeft;
    RAValue.font = [UIFont fontWithName:@"Verdana" size:10];
    [self.view addSubview:RAValue];

    textY = textY + 20;
        
        
        
        //horizontal highlight
        UILabel *gradient8Highlight = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        gradient8Highlight.backgroundColor = highlight;
        [self.view addSubview:gradient8Highlight];
        
        UIImageView *riseCover4 = [[UIImageView alloc] initWithImage:riseCover];
        [riseCover4 setFrame:CGRectMake(3,textY+3,rect.size.width - 3,20)];

        textY++;
        
        //vertical highlight
        UILabel *gradient8VerticalHighlight = [[UILabel alloc] initWithFrame:CGRectMake(2,bottomOfAbove,1,textY+2)];
        gradient8VerticalHighlight.backgroundColor = highlight;
        [self.view addSubview:gradient8VerticalHighlight];
        
        UILabel *gradient8 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,2)];
        gradient8.backgroundColor = borderColor;
        [self.view addSubview:gradient8];
        
        UILabel *gradientVertical8 = [[UILabel alloc] initWithFrame:CGRectMake(0,bottomOfAbove,2,textY+2)];
        gradientVertical8.backgroundColor = borderColor;
        [self.view addSubview:gradientVertical8];
        
        textY = textY + 2;
        bottomOfAbove = textY;

        
        
    UILabel *DEC = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,halfscreen,20)];
    DEC.text = NSLocalizedString(@"  Class", nil);
        DEC.backgroundColor = labelColor;
    DEC.textColor = [UIColor whiteColor];
    DEC.font = [UIFont fontWithName:@"Verdana" size:10];
        DEC.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:DEC];
        NSString *class;
        if([self.planet.name isEqualToString:(@"sun")]){
            class = @"star";
        }else if([self.planet.name isEqualToString:(@"moon")]){
            class = @"satellite";
        }else if([self.planet.name isEqualToString:(@"pluto")]){
            class = @"dwarf planet";
        }else{
            class = @"planet";
        }
    
    UILabel *DECValue = [[UILabel alloc] initWithFrame:CGRectMake(halfscreen,textY,textX,20)];
        DECValue.text = [NSString stringWithFormat:@"    %@", NSLocalizedString(class, nil)];
    DECValue.backgroundColor = labelColor;
    DECValue.textColor = [UIColor whiteColor];
    DECValue.textAlignment = NSTextAlignmentLeft;
    DECValue.font = [UIFont fontWithName:@"Verdana" size:10];
    [self.view addSubview:DECValue];

        //horizontal highlight
        UILabel *gradient9Highlight = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,1)];
        
        gradient9Highlight.backgroundColor = highlight;
       // [self.view addSubview:gradient9Highlight];
        textY++;
        
        //vertical highlight
        UILabel *gradient9VerticalHighlight = [[UILabel alloc] initWithFrame:CGRectMake(2,bottomOfAbove,1,textY+2)];
        gradient9VerticalHighlight.backgroundColor = highlight;
        [self.view addSubview:gradient9VerticalHighlight];
        
        UILabel *gradient9 = [[UILabel alloc] initWithFrame:CGRectMake(0,textY,rect.size.width,2)];
        gradient9.backgroundColor = borderColor;
       // [self.view addSubview:gradient9];
        
        UILabel *gradientVertical9 = [[UILabel alloc] initWithFrame:CGRectMake(0,bottomOfAbove,2,textY+2)];
        gradientVertical9.backgroundColor = borderColor;
        [self.view addSubview:gradientVertical9];
        
        textY = textY + 2;
        bottomOfAbove = textY;

    
    UILabel *leftGradient3 = [[UILabel alloc] initWithFrame:CGRectMake(0,bottomOfAbove,2,rect.size.height)];
    leftGradient3.backgroundColor = borderColor;
        
        
        
        [self.view addSubview:riseCover1];
        [self.view addSubview:riseCover2];
        [self.view addSubview:riseCover3];
        [self.view addSubview:riseCover4];
        [self.view addSubview:riseCover5];
    //[self.view addSubview:leftGradient3];
      //  }
    }

}

- (NSString *) createStringPlanet:(Planet *)planet Date:(NSDate *)date RiseHour:(NSString *)riseHour ZenithHour:(NSString *)zenithHour SetHour:(NSString *)setHour
{
    
    NSLog(@"PLANET NAME : (%@) ", planet.name);

    if ([planet.name isEqualToString:@"sun"]){
        return NSLocalizedString(@"The sun will rise in the morning and set in the evening.",nil);
    }
    else if ([planet.name isEqualToString:@"earth"]){
        return NSLocalizedString(@"The Earth can be seen most of the time.  Usually you look down.", nil);
    }else{
        
    //string  = [NSString stringWithFormat:NSLocalizedString(@"%@ %@.  %@ %@ %@, %@ %@ %@.", nil), NSLocalizedString(planet.name,nil), [RiseSetStrings takeTense:date], NSLocalizedString(planet.name,nil), [RiseSetStrings riseTense:date], [RiseSetStrings timeOfDay:riseHour], [RiseSetStrings And], [RiseSetStrings setTense:date], [RiseSetStrings timeOfDay:setHour]];
    }
    return [RiseSetStrings fullStringRise:(NSString *)riseHour Set:(NSString *)setHour Date:(NSDate *)date Planet:(Planet *)planet];
}

-(void)imageViewer
{
    
    NSString *background;
    
    NSString *planet = [self.planet.name lowercaseString];
    NSLog(@"%@",planet);
    NSLog(@"%@",[PlanetInfo bodyNameArray] );
    
    int indexValue = (int)[[PlanetInfo bodyNameArray] indexOfObject:[self.planet.name lowercaseString]];
    
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    
    CGRect rect = self.view.bounds;
    if(rect.size.height < 650){
        background = [PlanetInfo NASAPictureArraySm][indexValue];
    }else{
        background = [PlanetInfo NASAPictureArray][indexValue];
    }
    
    imageVC.name =[self.planet.name uppercaseString];
    imageVC.background = background;
    imageVC.credit = [PlanetInfo planetPictureCreditArray][indexValue];
    
    [self.navigationController pushViewController:imageVC animated:YES];
    
}

- (void) solarEclipse:(id)sender
{
    SolarEclipseViewController *solarEclipseVC = [[SolarEclipseViewController alloc] init];
    [self.navigationController pushViewController:solarEclipseVC animated:YES];
    
}

- (void) lunarEclipse:(id)sender
{
    LunarEclipseViewController *lunarEclipseVC = [[LunarEclipseViewController alloc] init];
    [self.navigationController pushViewController:lunarEclipseVC animated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    //if (self.sun.responseString || self.star.x  || self.planet.x || self.earth.x) {
    if(!self.planet.x && !self.sun.sunrise){
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
