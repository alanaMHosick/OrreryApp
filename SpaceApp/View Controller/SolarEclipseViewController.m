//
//  SolarEclipseViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.

//http://eclipse.gsfc.nasa.gov/SEdecade/SEdecade2011.html
//

#import "SolarEclipseViewController.h"
#import "Numbers.h"

@interface SolarEclipseViewController ()

@end

@implementation SolarEclipseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Solar Eclipse", @"Localizable", [NSBundle mainBundle], @"Solar Eclipse", @"this is a comment");
    
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
    self.scrollView.contentSize = CGSizeMake(320,2150);
    
    
    [self fillHomeView];
}




- (void) fillHomeView

{
    CGRect rect = [self.scrollView bounds];
    int width = rect.size.width;
    
    //int height = 2150;
    
    //int titleFontSize = 30;
    int fontSize = 20;
    int leftMargin = 10;
    int rightMargin = 10;
    int labelHeight = 58;
    int y = 20;
    int spacer = 10;
    //int bigSpacer = 15;
    
    UIColor *textColor = [UIColor whiteColor];
    UIColor *dividerColor = [UIColor darkGrayColor];
    UIColor *dividerHighlightColor = [UIColor grayColor];
    
    int dividerWidth = 5;
    int highlightWidth = 2;
    
    
    UILabel *dividerHighlight0 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight0.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight0];
    y = y + 2;
    
    UILabel *divider0 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider0.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider0];
    y = y + 5;
    
    y = y + spacer;

    
    
    ///////////////////////////  2014 4 29
    
    labelHeight = 20;
    UILabel *se1 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se1.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se1.textColor = textColor;
    se1.textAlignment = NSTextAlignmentCenter;
    se1.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2014-04-29"]];
    [self.scrollView addSubview:se1];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se1a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se1a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se1a.textColor = textColor;
    se1a.text = [NSString stringWithFormat:NSLocalizedString(@"Annular eclipse",nil)];
    [self.scrollView addSubview:se1a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se1b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se1b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se1b.textColor = textColor;
    se1b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Australia",nil)];
    [self.scrollView addSubview:se1b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight1 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight1.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight1];
    y = y + 2;

    UILabel *divider1 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider1.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider1];
    y = y + 5;
    
    y = y + spacer;
    
    
    ///////////////////////////  2014 11 23
    
    labelHeight = 20;
    UILabel *se2 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se2.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se2.textColor = textColor;
    se2.textAlignment = NSTextAlignmentCenter;
    se2.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2014-11-23"]];
    [self.scrollView addSubview:se2];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se2a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se2a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se2a.textColor = textColor;
    se2a.text = [NSString stringWithFormat:NSLocalizedString(@"Partial eclipse",nil)];
    [self.scrollView addSubview:se2a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se2b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se2b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se2b.textColor = textColor;
    se2b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"North America",nil)];
    [self.scrollView addSubview:se2b];
    
    y = y + labelHeight + spacer;

    UILabel *dividerHighlight2 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight2.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight2];
    y = y + 2;
    
    UILabel *divider2 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider2.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider2];
    y = y + 5;
    
    y = y + spacer;
    
    
    
    ///////////////////////////  2015/03/20
    
    labelHeight = 20;
    UILabel *se3 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se3.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se3.textColor = textColor;
    se3.textAlignment = NSTextAlignmentCenter;
    se3.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2015-03-20"]];
    [self.scrollView addSubview:se3];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se3a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se3a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se3a.textColor = textColor;
    se3a.text = [NSString stringWithFormat:NSLocalizedString(@"Total eclipse",nil)];
    [self.scrollView addSubview:se3a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se3b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se3b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se3b.textColor = textColor;
    se3b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Europe",nil)];
    [self.scrollView addSubview:se3b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight3 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight3.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight3];
    y = y + 2;
    
    UILabel *divider3 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider3.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider3];
    y = y + 5;
    
    y = y + spacer;

    
    ///////////////////////////  2015/09/13
    
    labelHeight = 20;
    UILabel *se4 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se4.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se4.textColor = textColor;
    se4.textAlignment = NSTextAlignmentCenter;
    se4.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2015-09-13"]];
    [self.scrollView addSubview:se4];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se4a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se4a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se4a.textColor = textColor;
    se4a.text = [NSString stringWithFormat:NSLocalizedString(@"Partial eclipse",nil)];
    [self.scrollView addSubview:se4a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se4b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se4b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se4b.textColor = textColor;
    se4b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Africa",nil)];
    [self.scrollView addSubview:se4b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight4 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight4.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight4];
    y = y + 2;
    
    UILabel *divider4 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider4.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider4];
    y = y + 5;
    
    y = y + spacer;


    ///////////////////////////  2016/03/09
    
    labelHeight = 20;
    UILabel *se5 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se5.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se5.textColor = textColor;
    se5.textAlignment = NSTextAlignmentCenter;
    se5.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2016-03-09"]];
    [self.scrollView addSubview:se5];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se5a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se5a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se5a.textColor = textColor;
    se5a.text = [NSString stringWithFormat:NSLocalizedString(@"Total eclipse",nil)];
    [self.scrollView addSubview:se5a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se5b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se5b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se5b.textColor = textColor;
    se5b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Pacific",nil)];
    [self.scrollView addSubview:se5b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight5 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight5.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight5];
    y = y + 2;
    
    UILabel *divider5 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider5.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider5];
    y = y + 5;
    
    y = y + spacer;

    
    
    ///////////////////////////  2016/09/01
    
    labelHeight = 20;
    UILabel *se6 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se6.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se6.textColor = textColor;
    se6.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2016-09-01"]];
    [self.scrollView addSubview:se6];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se6a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se6a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se6a.textColor = textColor;
    se6.textAlignment = NSTextAlignmentCenter;
    se6a.text = [NSString stringWithFormat:NSLocalizedString(@"Annular eclipse",nil)];
    [self.scrollView addSubview:se6a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se6b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se6b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se6b.textColor = textColor;
    se6b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Africa",nil)];
    [self.scrollView addSubview:se6b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight6 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight6.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight6];
    y = y + 2;
    
    UILabel *divider6 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider6.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider6];
    y = y + 5;
    
    y = y + spacer;

    
    
    
    ///////////////////////////  2017/02/26
    
    labelHeight = 20;
    UILabel *se7 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se7.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se7.textColor = textColor;
    se7.textAlignment = NSTextAlignmentCenter;
    se7.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2017-02-26"]];
    [self.scrollView addSubview:se7];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se7a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se7a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se7a.textColor = textColor;
    se7a.text = [NSString stringWithFormat:NSLocalizedString(@"Annular eclipse",nil)];
    [self.scrollView addSubview:se7a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se7b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se7b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se7b.textColor = textColor;
    se7b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Africa",nil)];
    [self.scrollView addSubview:se7b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight7 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight7.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight7];
    y = y + 2;
    
    UILabel *divider7 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider7.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider7];
    y = y + 5;
    
    y = y + spacer;

    
    
    ///////////////////////////  2017/08/21
    
    labelHeight = 20;
    UILabel *se8 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se8.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se8.textColor = textColor;
    se8.textAlignment = NSTextAlignmentCenter;
    se8.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2017-08-21"]];
    [self.scrollView addSubview:se8];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se8a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se8a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se8a.textColor = textColor;
    se8a.text = [NSString stringWithFormat:NSLocalizedString(@"Total eclipse",nil)];
    [self.scrollView addSubview:se8a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se8b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se8b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se8b.textColor = textColor;
    se8b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"North America",nil)];
    [self.scrollView addSubview:se8b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight8 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight8.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight8];
    y = y + 2;
    
    UILabel *divider8 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider8.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider8];
    y = y + 5;
    
    y = y + spacer;
    

    ///////////////////////////  2018/02/15
    
    labelHeight = 20;
    UILabel *se9 =[[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se9.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se9.textColor = textColor;
    se9.text = [NSString stringWithFormat:@"%@",[Numbers formatDate:@"2018-02-15"]];
    [self.scrollView addSubview:se9];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se9a = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se9a.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se9a.textColor = textColor;
    se9.textAlignment = NSTextAlignmentCenter;
    se9a.text = [NSString stringWithFormat:NSLocalizedString(@"Partial eclipse",nil)];
    [self.scrollView addSubview:se9a];
    
    y = y + labelHeight + spacer;
    
    labelHeight = 20;
    UILabel *se9b = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, y, width - rightMargin, labelHeight)];
    se9b.font = [UIFont fontWithName:@"Verdana" size:fontSize];
    se9b.textColor = textColor;
    se9b.text = [NSString stringWithFormat:NSLocalizedString(@"Visible from: %@",nil), NSLocalizedString(@"Antarctica",nil)];
    [self.scrollView addSubview:se9b];
    
    y = y + labelHeight + spacer;
    
    UILabel *dividerHighlight9 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, highlightWidth)];
    dividerHighlight9.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:dividerHighlight9];
    y = y + 2;
    
    UILabel *divider9 = [[UILabel alloc] initWithFrame:CGRectMake(0, y, width, dividerWidth)];
    divider9.backgroundColor = dividerColor;
    [self.scrollView addSubview:divider9];
    //y = y + 5;
    
    //y = y + spacer;
    
    
    
    
    
    
    


    
    
    
   
    
    
    ////////////// verticals /////////////////
    
    UILabel *verticalHighlightLeft = [[UILabel alloc] initWithFrame:CGRectMake(dividerWidth, 20, highlightWidth, y)];
    verticalHighlightLeft.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:verticalHighlightLeft];
    
    
    UILabel *verticalLeft = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, dividerWidth, y)];
    verticalLeft.backgroundColor = dividerColor;
    [self.scrollView addSubview:verticalLeft];
    
    
    UILabel *verticalHighlightRight = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width - highlightWidth - dividerWidth, 20, highlightWidth, y)];
    verticalHighlightRight.backgroundColor = dividerHighlightColor;
    [self.scrollView addSubview:verticalHighlightRight];
    
    
    UILabel *verticalRight= [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width  - dividerWidth, 20, width, y)];


    verticalRight.backgroundColor = dividerColor;
    [self.scrollView addSubview:verticalRight];


    
    
    [self.view addSubview:self.scrollView];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
