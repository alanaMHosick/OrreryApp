//
//  Home.m
//  Space
//
//  Created by Alana Hosick on 1/21/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Home.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"


@implementation Home

- (id)init;
{
    self = [self initWithJSON];
    return self;
}



- (id)initWithJSON
{
    self = [super init];
    if(self) {
        NSURL *url = [[NSURL alloc] initWithString:@"http://marsweather.ingenology.com/v1/latest"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:2 timeoutInterval:100];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            self.date = JSON[@"report"][@"terrestrial_date"];
            NSLog(@"%@", self.date);
            self.sol = [JSON[@"report"][@"sol"] stringValue];
            self.atmosphere = JSON[@"report"][@"atmo_opacity"];
            self.highTemp = [JSON[@"report"][@"max_temp_fahrenheit"] stringValue];
            self.lowTemp = [JSON[@"report"][@"min_temp_fahrenheit"] stringValue];
            self.pressure = [JSON[@"report"][@"pressure"] stringValue];
            self.season = JSON[@"report"][@"pressure"];
            self.pressureChange = [JSON[@"report"][@"pressure_string"] lowercaseString];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
        
        
    }
       return self;
}


@end
