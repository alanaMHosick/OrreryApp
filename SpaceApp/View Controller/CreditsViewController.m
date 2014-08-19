//
//  CreditsViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/25/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "CreditsViewController.h"
#import "Screen.h"
@interface CreditsViewController ()

@end

@implementation CreditsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Image Credits", @"Localizable", [NSBundle mainBundle], @"Image Credits", @"this is a comment");
        //self.tabBarItem.image = [UIImage imageNamed:@"Wall-E-icon"];
         self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hubbleTerzanStarfield.jpg"]];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"starrySky3.jpg"]];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320,2550);

    
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
    int labelHeight = 58;
    int y = 20;
    int spacer = 20;
    
    UIColor *bg = [UIColor clearColor];
    
    
    
    //NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    
    labelHeight = 120;
    UILabel *sunImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    sunImage.backgroundColor = bg;
    sunImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    sunImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    sunImage.numberOfLines = 6;
    sunImage.lineBreakMode = NSLineBreakByCharWrapping;
    sunImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of the sun is a NASA/ESA image. This Extreme Ultraviolet Imaging Telescope (EIT) image was taken on Sept. 14,1999.  Accessed from https://solarsystem.nasa.gov/multimedia/display.cfm on February 26, 2014",nil)];
    [self.scrollView addSubview:sunImage];
    
    y = y + labelHeight + spacer;

    
    labelHeight = 120;
    UILabel *mercuryImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    mercuryImage.backgroundColor = bg;
    mercuryImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    mercuryImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    mercuryImage.numberOfLines = 6;
    mercuryImage.lineBreakMode = NSLineBreakByCharWrapping;
    mercuryImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of the planet Mercury is a NASA image taken on the MESSENGER mission in 2008.  Accessed from http://www.nasa.gov/connect/chat/messenger_chat.html on February 25, 2014",nil)];
    [self.scrollView addSubview:mercuryImage];
    
    y = y + labelHeight + spacer;
    
    
    labelHeight = 150;
    UILabel *venusImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    venusImage.backgroundColor = bg;
    venusImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    venusImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    venusImage.numberOfLines = 8;
    venusImage.lineBreakMode = NSLineBreakByCharWrapping;
    venusImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of the planet Venus is a NASA image composite.  It was taken on both the Magellan mission and the pioneer orbiter mission.  The images were put together with simulated color.  Accessed from https://solarsystem.nasa.gov/multimedia/display.cfm on February 25, 2014",nil)];
    [self.scrollView addSubview:venusImage];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 120;
    UILabel *earthImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    earthImage.backgroundColor = bg;
    earthImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    earthImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    earthImage.numberOfLines = 6;
    earthImage.lineBreakMode = NSLineBreakByCharWrapping;
    earthImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of the planet Earth is a NASA image.  It was taken December 22, 1968, by the Apollo 8 crew. Accessed from http://earthobservatory.nasa.gov/IOTD/view.php?id=36019 on February 25, 2014",nil)];
    [self.scrollView addSubview:earthImage];
    
    y = y + labelHeight + spacer;
    
    
    labelHeight = 100;
    UILabel *moonImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    moonImage.backgroundColor = bg;
    moonImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    moonImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    moonImage.numberOfLines = 5;
    moonImage.lineBreakMode = NSLineBreakByCharWrapping;
    moonImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Earth's moon is a NASA image.  It was taken by the Lunar Reconnaissance Orbiter. Accessed from http://photojournal.jpl.nasa.gov/catalog/PIA14021 on February 25, 2014",nil)];
    [self.scrollView addSubview:moonImage];
    
    y = y + labelHeight + spacer;
    
    
    
    labelHeight = 130;
    UILabel *marsImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    marsImage.backgroundColor = bg;
    marsImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    marsImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    marsImage.numberOfLines = 7;
    marsImage.lineBreakMode = NSLineBreakByCharWrapping;
    marsImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Mars is a ESA image.  The image was acquired by the Visual Monitoring Camera on the Mars orbiter during the Mars Express Mission. Accessed from https://solarsystem.nasa.gov/multimedia/gallery on February 25, 2014",nil)];
    [self.scrollView addSubview:marsImage];
    
    y = y + labelHeight + spacer;

    
    labelHeight = 150;
    UILabel *jupiterImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    jupiterImage.backgroundColor = bg;
    jupiterImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    jupiterImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    jupiterImage.numberOfLines = 8;
    jupiterImage.lineBreakMode = NSLineBreakByCharWrapping;
    jupiterImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Jupiter is a NASA image. This image is composed of four images taken by NASA's Cassini spacecraft on December 7th 2000. Accessed from https://solarsystem.nasa.gov/multimedia/gallery/Full_Disk_Jupiter1.jpg on February 25, 2014",nil)];
    [self.scrollView addSubview:jupiterImage];
    
    y = y + labelHeight + spacer;
    

    labelHeight = 170;
    UILabel *saturnImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    saturnImage.backgroundColor = bg;
    saturnImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    saturnImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    saturnImage.numberOfLines = 9;
    saturnImage.lineBreakMode = NSLineBreakByCharWrapping;
    saturnImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Saturn is a NASA image. It was taken in early October 2004, Cassini captured a series of images that have been composed into this large global natural color view of Saturn and its rings. Accessed from https://solarsystem.nasa.gov/multimedia/gallery/True_Saturn.jpg on February 25, 2014",nil)];
    [self.scrollView addSubview:saturnImage];
    
    y = y + labelHeight + spacer;

    
    labelHeight = 130;
    UILabel *uranusImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    uranusImage.backgroundColor = bg;
    uranusImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    uranusImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    uranusImage.numberOfLines = 7;
    uranusImage.lineBreakMode = NSLineBreakByCharWrapping;
    uranusImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Uranus is a NASA image. This image was taken by the Hubble Space Telescope on January 1, 2006.  Accessed from https://solarsystem.nasa.gov/multimedia/display.cfm on February 25, 2014",nil)];
    [self.scrollView addSubview:uranusImage];
    
    y = y + labelHeight + spacer;

    
    labelHeight = 150;
    UILabel *neptuneImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    neptuneImage.backgroundColor = bg;
    neptuneImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    neptuneImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    neptuneImage.numberOfLines = 8;
    neptuneImage.lineBreakMode = NSLineBreakByCharWrapping;
    neptuneImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Neputune is a NASA image. This picture of Neptune was produced from the last whole planet images taken through the green and orange filters on the Voyager 2 narrow angle camera. Accessed from https://solarsystem.nasa.gov/multimedia/display.cfm on February 25, 2014",nil)];
    [self.scrollView addSubview:neptuneImage];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 140;
    UILabel *plutoImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    plutoImage.backgroundColor = bg;
    plutoImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    plutoImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    plutoImage.numberOfLines = 7;
    plutoImage.lineBreakMode = NSLineBreakByCharWrapping;
    plutoImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Pluto is a ESA image.   The image was taken by the European Space Agency's Faint Object Camera on February 21, 1994  Accessed from https://solarsystem.nasa.gov/multimedia/display.cfm on February 25, 2014",nil)];
    [self.scrollView addSubview:plutoImage];
    
    y = y + labelHeight + spacer;
    
    
    
    labelHeight = 130;
    UILabel *ceresImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    ceresImage.backgroundColor = bg;
    ceresImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    ceresImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    ceresImage.numberOfLines = 7;
    ceresImage.lineBreakMode = NSLineBreakByCharWrapping;
    ceresImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Ceres is a NASA image.  It was taken by the hubble telescope in 2004. Accessed from https://solarsystem.nasa.gov/multimedia/display.cfm?Category=Planets&IM_ID=10723 on February 25, 2014",nil)];
    [self.scrollView addSubview:ceresImage];
    
    y = y + labelHeight + spacer;


    labelHeight = 120;
    UILabel *erisImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    erisImage.backgroundColor = bg;
    erisImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    erisImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    erisImage.numberOfLines = 6;
    erisImage.lineBreakMode = NSLineBreakByCharWrapping;
    erisImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of Eris is a NASA image. This is not a photo but an artist's rendering. http://http://discovery.nasa.gov/SmallWorlds/images/Eris. on February 25, 2014",nil)];
    [self.scrollView addSubview:erisImage];
    
    
     y = y + labelHeight + spacer;
    labelHeight = 150;
    UILabel *marsLandscapeImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    marsLandscapeImage.backgroundColor = bg;
    marsLandscapeImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    marsLandscapeImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    marsLandscapeImage.numberOfLines = 8;
    marsLandscapeImage.lineBreakMode = NSLineBreakByCharWrapping;
    marsLandscapeImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of the Martian landscape (Shown on the Curisoty screen) is a NASA image.  It was taken by Curiosity on February 14, 2013 during the Mars Science Laboratory Mission. Accessed from http://photojournal.jpl.nasa.gov/catalog/PIA17603 on February 25, 2014",nil)];
    [self.scrollView addSubview:marsLandscapeImage];
    
    y = y + labelHeight + spacer;
    
    UILabel *terzanHubbleImage =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    terzanHubbleImage.backgroundColor = bg;
    terzanHubbleImage.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    terzanHubbleImage.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    terzanHubbleImage.numberOfLines = 7;
    terzanHubbleImage.lineBreakMode = NSLineBreakByCharWrapping;
    terzanHubbleImage.text = [NSString stringWithFormat:NSLocalizedString(@"The image of the globular cluster Terzan 7 (Shown as the background of this screen) is a NASA/ESA image taken by the Hubble telescope.  Accessed from http://www.nasa.gov/content/goddard/hubble-looks-into-terzan-7 on February 26, 2014",nil)];
    [self.scrollView addSubview:terzanHubbleImage];

    y = y + labelHeight + spacer;
    
    labelHeight = 160;
    UILabel *icons =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    icons.backgroundColor = bg;
    icons.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    icons.textColor = [UIColor whiteColor];
    //creditTitle.textAlignment = NSTextAlignmentCenter;
    icons.numberOfLines = 9;
    icons.lineBreakMode = NSLineBreakByCharWrapping;
    icons.text = [NSString stringWithFormat:NSLocalizedString(@"The solar system icons artwork was done by Dan Wiersema and are free for non-commercial use.  The icons were taken from http://icons.iconseeker.com on January 15, 2014.  The licence can be found at http://icons.iconseeker.com/license/solar-system/readme.txt",nil)];
    [self.scrollView addSubview:icons];
    
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
