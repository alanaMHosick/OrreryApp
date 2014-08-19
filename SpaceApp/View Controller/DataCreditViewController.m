//
//  DataCreditViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "DataCreditViewController.h"

@interface DataCreditViewController ()

@end

@implementation DataCreditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Data Credits", @"Localizable", [NSBundle mainBundle], @"Data Credits", @"this is a comment");
        //self.tabBarItem.image = [UIImage imageNamed:@"Wall-E-icon"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hubbleTerzanStarfield.jpg"]];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"starrySky3.jpg"]];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320,2000);
    
    
    [self fillHomeView];
}




- (void) fillHomeView

{
    CGRect rect = [self.view bounds];
    int width = rect.size.width;
    
    //int titleFontSize = 30;
    int fontSize = 15;
    int leftMargin = 10;
    int rightMargin = 10;
    int labelHeight = 80;
    int y = 20;
    int spacer = 20;
    
    //UIColor *bg = [UIColor clearColor];
    
    
    
    //NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    
       
    UILabel *meeus =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[meeus sizeToFit];
    meeus.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    meeus.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    meeus.numberOfLines = 4;
    meeus.lineBreakMode = NSLineBreakByCharWrapping;
    meeus.text = [NSString stringWithFormat:NSLocalizedString(@"Caluclations for planetary rise, transit, and set are based on an algorithm from 'Astronomical Algorithms' by Jean Meeus.'",nil)];
    [self.scrollView addSubview:meeus];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 100;
    UILabel *wybiral =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[meeus sizeToFit];
    wybiral.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    wybiral.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    wybiral.numberOfLines = 5;
    wybiral.lineBreakMode = NSLineBreakByCharWrapping;
    wybiral.text = [NSString stringWithFormat:NSLocalizedString(@"The webservice used to get planetary coordinates was written by Davy Wybiral and can be found at http://www.astro-phys.com/api.  The ephemeris being used is DE406.",nil)];
    [self.scrollView addSubview:wybiral];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 60;
    UILabel *maas =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[meeus sizeToFit];
    maas.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    maas.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    maas.numberOfLines = 4;
    maas.lineBreakMode = NSLineBreakByCharWrapping;
    maas.text = [NSString stringWithFormat:NSLocalizedString(@"The webservice used to get the weather conditions on Mars was found on open.nasa.gov.",nil)];
    [self.scrollView addSubview:maas];
    
    y = y + labelHeight + spacer;
    
    
    UILabel *sun =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[meeus sizeToFit];
    sun.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    sun.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    sun.numberOfLines = 4;
    sun.lineBreakMode = NSLineBreakByCharWrapping;
    sun.text = [NSString stringWithFormat:NSLocalizedString(@"For some of the calculations, sunrise and sunset are needed.  The webservice used for this data is www.earthtools.org.",nil)];
    [self.scrollView addSubview:sun];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 160;
    UILabel *google =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[meeus sizeToFit];
    google.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    google.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    google.numberOfLines = 8;
    google.lineBreakMode = NSLineBreakByCharWrapping;
    google.text = [NSString stringWithFormat:NSLocalizedString(@"Calculations for planetary rise, set, and transit give results for timezone GMT.  If no timezone is entered the times for events will be off by the amount of the timezone offset.  The webservice used to fill in the timezone automatically as well as the elevation can be found at maps.googleapis.com.",nil)];
    [self.scrollView addSubview:google];
    
    y = y + labelHeight + spacer;



    labelHeight = 160;

    //labelHeight = labelHeight+ (fontSize * 4);
    UILabel *estimate =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[estimate sizeToFit];
    estimate.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    estimate.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    estimate.numberOfLines = 8;
    estimate.lineBreakMode = NSLineBreakByCharWrapping;
    estimate.text = [NSString stringWithFormat:NSLocalizedString(@"The times for planetary rise, transit and set are estimates.  Some of the variables that go into the calculation could not be computed with a high degree of accuracy.  The results tend to be within five or ten minutes of other sources but in some cases, could be more.",nil)];
    [self.scrollView addSubview:estimate];
    
     y = y + labelHeight + spacer;
    
    labelHeight = 95;
    UILabel *RADEC =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[estimate sizeToFit];
    RADEC.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    RADEC.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    RADEC.numberOfLines = 5;
    RADEC.lineBreakMode = NSLineBreakByCharWrapping;
    RADEC.text = [NSString stringWithFormat:NSLocalizedString(@"The values for right ascension and declination are not exact.  They are estimates based on the angle of the planet to the sun and the earth to the sun.",nil)];
    [self.scrollView addSubview:RADEC];

    
    y = y + labelHeight + spacer;
    
    labelHeight = 60;
    UILabel *eclipse =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    //[estimate sizeToFit];
    eclipse.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    eclipse.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    eclipse.numberOfLines = 4;
    eclipse.lineBreakMode = NSLineBreakByCharWrapping;
    eclipse.text = [NSString stringWithFormat:NSLocalizedString(@"The data for solar and lunar eclipses was found on http://eclipse.gsfc.nasa.gov",nil)];
    [self.scrollView addSubview:eclipse];
    
    
    y = y + labelHeight + spacer;

    
    
    
    
    [self.view addSubview:self.scrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
