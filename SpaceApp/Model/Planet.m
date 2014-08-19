//
//  Planet.m
//  Space
//
//  Created by Alana Hosick on 1/26/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

// data from:
// http://davywybiral.blogspot.com/2011/11/planetary-states-api.html

#import "Planet.h"
#import "Math.h"
#import "AFJSONRequestOperation.h"
#import "URLcheck.h"
#import "ErrorAlert.h"

@implementation Planet

- (id)init
{
    self = [super init];
    return self;
}


- (id)initPlanet:(NSString *)name Date:(NSDate *)date
{
    self = [super init];
    self.name = name;
    NSString *dateString = [Math formatDate:date];
    NSLog(@"Date: %@", dateString);
    NSLog(@"Name: %@", name);
    
     NSDictionary *distances = [[NSDictionary alloc] initWithObjectsAndKeys:@"35", @"mercury", @"45", @"venus", @"62", @"earth", @"80", @"mars", @"95", @"jupiter", @"110", @"saturn", @"130", @"uranus", @"155", @"neptune", nil];
    
    if(self) {
        
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=%@", dateString, self.name];
        NSLog(@" %@",searchString);
       
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:2 timeoutInterval:100];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSLog(@"%@", JSON);
            NSString *error = JSON[@"error"];
            
            if(!error){
            
                NSLog(@"string does not contain error");
            
            
                self.x = [JSON[@"results"][self.name][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.y = [JSON[@"results"][self.name][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.z = [JSON[@"results"][self.name][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.graphDistance = [distances[self.name] integerValue];
            
            } else {
                [ErrorAlert errorAlert:error];
            }

            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSONFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        
        [operation start];
    }
    return self;
}

    
    
    
    





@end
