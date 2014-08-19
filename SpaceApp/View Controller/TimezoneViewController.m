//
//  TimezoneViewController.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "TimezoneViewController.h"
#import "UserLocation.h"
#import "Numbers.h"

@interface TimezoneViewController ()

@end

@implementation TimezoneViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedStringWithDefaultValue(@"Timezone", @"Localizable", [NSBundle mainBundle], @"Timezone", nil);
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    //cell.imageView.image = [UIImage imageNamed:self.planetThumbs[indexPath.row]];
    if (indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   International Dateline  ", @"this is a comment"), -12];//[Numbers formatStr:@"-12"Digits:1 Decimals:0]];
    }else if (indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Nome  ", @"this is a comment"), -11];
    }else if (indexPath.row == 3){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Alaska - Hawaii Standard  ", @"this is a comment"), -10];
    }else if (indexPath.row == 4){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Yukon Standard  ", @"this is a comment"), -9];
    }else if (indexPath.row == 5){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Pacific Standard  ", @"this is a comment"), -8];
    }else if (indexPath.row == 6){
         cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Mountain Standard  ", @"this is a comment"), -7];
    }else if (indexPath.row == 7){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Central Standard  ", @"this is a comment"), -6];
    }else if (indexPath.row == 8){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Eastern Standard  ", @"this is a comment"), -5];
    }else if (indexPath.row == 9){
       cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Atlantic Standard  ", @"this is a comment"), -4];
    }else if (indexPath.row == 10){
            cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT - 3  ", @"this is a comment"), -3];
    }else if (indexPath.row == 11){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Azores  ", @"this is a comment"), -2];
    }else if (indexPath.row == 12){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   West Africa  ", @"this is a comment"), -1];
    }else if (indexPath.row == 13){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT  ", @"this is a comment"), 0];
    }else if (indexPath.row == 14){
        cell.textLabel.text =[NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Central European  ", @"this is a comment"), 1];
    }else if (indexPath.row == 15){
      cell.textLabel.text =  [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Eastern European  ", @"this is a comment"), 2];
    }else if (indexPath.row == 16){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT + 3  ", @"this is a comment"), 3];
    }else if (indexPath.row == 17){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT + 4  ", @"this is a comment"), 4];
    }else if (indexPath.row == 18){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT + 5  ", @"this is a comment"), 5];
    }if (indexPath.row == 19){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT + 6  ", @"this is a comment"), 6];
    }else if (indexPath.row == 20){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT + 7  ", @"this is a comment"), 7];
    }else if (indexPath.row == 21){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   China Coast  ", @"this is a comment"), 8];
    }else if (indexPath.row == 22){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Japan Standard  ", @"this is a comment"), 9];
    }else if (indexPath.row == 23){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   Guam Standard  ", @"this is a comment"), 10];
    }else if (indexPath.row == 24){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   GMT + 11  ", @"this is a comment"), 11];
    }else if (indexPath.row == 25){
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedStringWithDefaultValue(@"  %d   timezoneName  ", @"Localizable", [NSBundle mainBundle], @"  %d   New Zealand Standard  ", @"this is a comment"), 12];    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    userTimezone = (int)(indexPath.row - 13);
    NSLog(@"timezone %d", userTimezone);
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
