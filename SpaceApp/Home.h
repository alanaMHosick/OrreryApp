//
//  Home.h
//  Space
//
//  Created by Alana Hosick on 1/21/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Home : NSObject

@property (strong, nonatomic)NSString *lowTemp;
@property (strong, nonatomic)NSString *highTemp;
@property (strong, nonatomic)NSString *atmosphere;
@property (strong, nonatomic)NSString *sol;
@property (strong, nonatomic)NSString *date;
@property (strong, nonatomic)NSString *season;
@property (strong, nonatomic)NSString *pressure;
@property (strong, nonatomic)NSString *pressureChange;


-(id)initWithJSON;

@end
