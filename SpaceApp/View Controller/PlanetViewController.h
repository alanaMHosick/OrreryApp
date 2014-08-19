//
//  PlanetViewController.h
//  Space
//
//  Created by Alana Hosick on 1/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class Planet;
@interface PlanetViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) NSString *planetPicture;
@property (strong, nonatomic) NSString *planetName;
@property Planet *currentPlanet;
@property Planet *earth;
@property Planet *sun;
@property int bodyNumber;
@property NSString *distance;
@property NSDate *date;
@property UIActivityIndicatorView *spinner;
@property double latitude;
@property double longitude;

- (id) loadSelfInformationFromTag:(int)tag;


@end
