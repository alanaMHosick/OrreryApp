//
//  Location.m
//  Space
//
//  Created by Alana Hosick on 1/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Location.h"
#import "Home.h"
#import "Math.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"


@implementation Location

- (id)init;
{
    
    self = [self initMercuryWithJSON];
    self = [self initVenusWithJSON];
    self = [self initEarthWithJSON];
    self = [self initMarsWithJSON];
    self = [self initJupiterWithJSON];
    self = [self initSaturnWithJSON];
    self = [self initUranusWithJSON];
    self = [self initNeptuneWithJSON];
    
    
    if(self.xMars){
        
    }
    
    
    return self;
}

- (id)initMercuryWithJSON
{
    self = [super init];
    if(self) {
        
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=mercury", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xMercury = [JSON[@"results"][@"mercury"][0][0] doubleValue];
            self.yMercury = [JSON[@"results"][@"mercury"][0][1] doubleValue];
            self.zMercury = [JSON[@"results"][@"mercury"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initVenusWithJSON
{
    self = [super init];
    if(self) {
        
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=venus", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xVenus = [JSON[@"results"][@"venus"][0][0] doubleValue];
            self.yVenus = [JSON[@"results"][@"venus"][0][1] doubleValue];
            self.zVenus = [JSON[@"results"][@"venus"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initEarthWithJSON
{
    self = [super init];
    if(self) {
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=earth", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xEarth = [JSON[@"results"][@"earth"][0][0] doubleValue];
            self.yEarth = [JSON[@"results"][@"earth"][0][1] doubleValue];
            self.zEarth = [JSON[@"results"][@"earth"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initMarsWithJSON
{
    self = [super init];
    if(self) {
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=mars", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xMars = [JSON[@"results"][@"mars"][0][0] doubleValue];
            self.yMars = [JSON[@"results"][@"mars"][0][1] doubleValue];
            self.zMars = [JSON[@"results"][@"mars"][0][2] doubleValue];
            
            self.xVMars = [JSON[@"results"][@"mars"][1][0] doubleValue];
            self.yVMars = [JSON[@"results"][@"mars"][1][1] doubleValue];
            self.zVMars = [JSON[@"results"][@"mars"][1][2] doubleValue];

            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initJupiterWithJSON
{
    self = [super init];
    if(self) {
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=jupiter", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xJupiter = [JSON[@"results"][@"jupiter"][0][0] doubleValue];
            self.yJupiter = [JSON[@"results"][@"jupiter"][0][1] doubleValue];
            self.zJupiter = [JSON[@"results"][@"jupiter"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initSaturnWithJSON
{
    self = [super init];
    if(self) {
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=saturn", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xSaturn = [JSON[@"results"][@"saturn"][0][0] doubleValue];
            self.ySaturn = [JSON[@"results"][@"saturn"][0][1] doubleValue];
            self.zSaturn = [JSON[@"results"][@"saturn"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initUranusWithJSON
{
    self = [super init];
    if(self) {
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=uranus", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xUranus = [JSON[@"results"][@"uranus"][0][0] doubleValue];
            self.yUranus = [JSON[@"results"][@"uranus"][0][1] doubleValue];
            self.zUranus = [JSON[@"results"][@"uranus"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

- (id)initNeptuneWithJSON
{
    self = [super init];
    if(self) {
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=neptune", [Math getCurrentDate]];
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            self.xNeptune = [JSON[@"results"][@"neptune"][0][0] doubleValue];
            self.yNeptune = [JSON[@"results"][@"neputne"][0][1] doubleValue];
            self.zNeptune = [JSON[@"results"][@"neptune"][0][2] doubleValue];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}


@end
