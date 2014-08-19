//
//  SunriseViewController.m
//  Space
//
//  Created by Alana Hosick on 1/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "SunriseViewController.h"
#import "Parser.h"
#import "URLcheck.h"

@interface SunriseViewController ()

@end

@implementation SunriseViewController

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
	if (self) {
        
                
        NSLog(@"sunrise %Lf", self.latitude);
        NSLog(@"sunrise %Lf", self.longitude);
        
        self.sun =[[Sun alloc]initSunLat:(long double)self.latitude Long:(long double)self.longitude Date:(NSDate *)self.date DST:(BOOL)self.dst];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sun256"]];
        imageView.frame = CGRectMake(100,200,300,300);
        [self.view addSubview:imageView];
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_spinner setCenter:CGPointMake([self.view bounds].size.width/2.0, [self.view bounds].size.height/2.0)];
        [self.view addSubview:_spinner];
        [_spinner startAnimating];
        
        if([URLcheck canConnectTo:@"http://www.earthtools.org"]){

        [self fillSplashView];

        }
    }

}

- (void) fillSplashView
{
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,80,280,40)];
    dateLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = [Math formatDate:self.date];
    [self.view addSubview:dateLabel];
    NSLog(@" calling parser for: %@",self.sun.responseString );
    
    if(self.sun.responseString){
        [_spinner stopAnimating];
        self.sun.sunrise = [Parser getValueForKey:(NSString *)@"sunrise" inString:(NSString *)self.sun.responseString];
        self.sun.sunset = [Parser getValueForKey:(NSString *)@"sunset" inString:(NSString *)self.sun.responseString];
        
        UILabel *sunriseLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,110,280,40)];
        sunriseLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        sunriseLabel.textColor = [UIColor whiteColor];
        sunriseLabel.textAlignment = NSTextAlignmentCenter;
        sunriseLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Sunrise:   %@", nil), self.sun.sunrise];
        [self.view addSubview:sunriseLabel];

        UILabel *sunsetLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,140,280,40)];
        sunsetLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        sunsetLabel.textColor = [UIColor whiteColor];
        sunsetLabel.textAlignment = NSTextAlignmentCenter;
        sunsetLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Sunset:   %@", nil),self.sun.sunset];
        [self.view addSubview:sunsetLabel];

        
    }
    
    UILabel *latLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,340,280,40)];
    latLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    latLabel.textColor = [UIColor whiteColor];
    latLabel.text = NSLocalizedString(@"latitude", nil);
    [self.view addSubview:latLabel];
    
    UILabel *latValue = [[UILabel alloc] initWithFrame:CGRectMake(12,360,280,40)];
    latValue.font = [UIFont fontWithName:@"Helvetica" size:13];
    latValue.textColor = [UIColor whiteColor];
    latValue.text = [NSString stringWithFormat:@"   %LF",self.latitude];
    [self.view addSubview:latValue];
    
    UILabel *lonLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,380,280,40)];
    lonLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    lonLabel.textColor = [UIColor whiteColor];
    lonLabel.text = NSLocalizedString(@"longitude", nil);
    [self.view addSubview:lonLabel];

    UILabel *lonValue = [[UILabel alloc] initWithFrame:CGRectMake(12,400,280,40)];
    lonValue.font = [UIFont fontWithName:@"Helvetica" size:13];
    lonValue.textColor = [UIColor whiteColor];
    lonValue.text = [NSString stringWithFormat:@"   %LF",self.longitude];
    [self.view addSubview:lonValue];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.sun.responseString) {
        [super viewWillAppear:animated];
        NSLog(@"%@",self.sun.responseString );
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillSplashView) name:@"initWithHTTPFinishedLoading" object:nil];
    }else{
        NSLog(@"%@",self.sun.responseString );
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
