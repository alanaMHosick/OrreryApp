//
//  AppDelegate.m
//  Space
//
//  Created by Alana Hosick on 1/21/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "AppDelegate.h"
#import "PlanetsTableViewController.h"
#import "ViewerViewController.h"
#import "CuriosityViewController.h"
#import "Home.h"
#import "SWRevealViewController.h"
#import "SettingsViewController.h"
#import "OrreryViewController.h"
#import "UserLocation.h"
#import "InfoViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface AppDelegate()<SWRevealViewControllerDelegate>
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[[NSUserDefaults standardUserDefaults] registerDefaults:userLocation];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window = window;

    PlanetsTableViewController *planetsTableViewController = [[PlanetsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *planetsNavController = [[UINavigationController alloc] initWithRootViewController:planetsTableViewController];
    
    OrreryViewController *orreryViewController = [[OrreryViewController alloc] init];
    UINavigationController *orreryNavController = [[UINavigationController alloc] initWithRootViewController:orreryViewController];

    ViewerViewController *viewerViewController = [[ViewerViewController alloc] init];
    UINavigationController *viewerNavController = [[UINavigationController alloc] initWithRootViewController:viewerViewController];
    
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    
    CuriosityViewController *curiosityViewController = [[CuriosityViewController alloc] init];
    UINavigationController *curiosityNavController = [[UINavigationController alloc] initWithRootViewController:curiosityViewController];
    
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    UINavigationController *infoNavController = [[UINavigationController alloc] initWithRootViewController:infoViewController];
    
   
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    tabBarController.viewControllers = @[curiosityNavController, orreryNavController, viewerNavController, planetsNavController, infoNavController];//, dateNavController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:settingsViewController frontViewController:tabBarController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = revealController;
    [self.window makeKeyAndVisible];
    
    return YES;

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
