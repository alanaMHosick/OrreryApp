//
//  PlanetsTableViewController.m
//  Space
//
//  Created by Alana Hosick on 1/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "PlanetsTableViewController.h"
#import "PlanetViewController.h"

@interface PlanetsTableViewController ()

@end

@implementation PlanetsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Bodies";
        self.tabBarItem.image = [UIImage imageNamed:@"saturn32-icon"];
        self.planets = @[@"Sun", @"Mercury", @"Venus", @"Earth", @"Moon", @"Mars", @"Ceres", @"Jupiter", @"Saturn", @"Uranus", @"Neptune", @"Pluto", @"eris"];
        self.planetThumbs = @[@"sun32", @"mercury-icon", @"venus-icon", @"earth2-icon", @"moon32", @"mars32-icon", @"ceres32", @"jupiter-icon", @"saturn32-icon", @"uranus-icon", @"neptune-icon", @"pluto32", @"eris23"];
        self.planetPictures = @[@"sun256", @"mercury256", @"venus256", @"earth256", @"moon256", @"mars256", @"ceres256", @"jupiter256", @"saturn256", @"uranus256", @"neptune256", @"pluto256", @"eris256"];
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
    NSLog(@" %d", self.planets.count);
    return self.planets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.planetThumbs[indexPath.row]];
    cell.textLabel.text = self.planets[indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlanetViewController *planetVC = [[PlanetViewController alloc] init];
    planetVC.planetPicture = self.planetPictures[indexPath.row];
    planetVC.title = self.planets[indexPath.row];
    planetVC.planetName = self.planets[indexPath.row];
    [self.navigationController pushViewController:planetVC animated:YES];
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
