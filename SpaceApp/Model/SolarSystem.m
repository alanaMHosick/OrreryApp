//
//  SolarSystem.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "SolarSystem.h"
#import "ErrorAlert.h"
#import "Planet.h"
#import "Math.h"
#import "AFJSONRequestOperation.h"

@implementation SolarSystem

- (id)initSolarSystemFor:(NSDate *)date
{
    
    self = [super init];
    
    
    self.sun = [[Planet alloc] init];
    self.mercury = [[Planet alloc] init];
    self.venus = [[Planet alloc] init];
    self.earth = [[Planet alloc] init];
    self.moon = [[Planet alloc] init];
    self.mars = [[Planet alloc] init];
    self.jupiter = [[Planet alloc] init];
    self.saturn = [[Planet alloc] init];
    self.uranus = [[Planet alloc] init];
    self.neptune = [[Planet alloc] init];
    self.pluto = [[Planet alloc] init];
    
    
    
    NSString *dateString = [Math formatDate:date];
    NSLog(@"Date: %@", dateString);
    
    NSDictionary *distances = [[NSDictionary alloc] initWithObjectsAndKeys:@"0", @"sun",@"35", @"mercury", @"45", @"venus", @"62", @"earth", @"80", @"mars", @"95", @"jupiter", @"110", @"saturn", @"130", @"uranus", @"155", @"neptune", nil];

    if(self) {
        
        NSString *searchString = [NSString stringWithFormat:@"http://www.astro-phys.com/api/de406/states?date=%@&bodies=sun,mercury,venus,earth,moon,mars,jupiter,saturn,uranus,neptune,pluto", dateString];
        NSLog(@" %@",searchString);
        
        NSURL *url = [[NSURL alloc] initWithString:searchString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:2 timeoutInterval:100];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSLog(@"%@", JSON);
            NSString *error = JSON[@"error"];
            
            if(!error){
                
                NSLog(@"string does not contain error");
                self.sun.name = @"sun";
                self.sun.x = [JSON[@"results"][@"sun"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.sun.y = [JSON[@"results"][@"sun"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.sun.z = [JSON[@"results"][@"sun"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.sun.graphDistance = [distances[@"sun"] integerValue];
                
                self.mercury.name = @"mercury";
                self.mercury.x = [JSON[@"results"][@"mercury"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.mercury.y = [JSON[@"results"][@"mercury"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.mercury.z = [JSON[@"results"][@"mercury"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.mercury.graphDistance = [distances[@"mercury"] integerValue];
                
                self.venus.name = @"venus";
                self.venus.x = [JSON[@"results"][@"venus"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.venus.y = [JSON[@"results"][@"venus"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.venus.z = [JSON[@"results"][@"venus"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.venus.graphDistance = [distances[@"venus"] integerValue];

                self.earth.name = @"earth";
                self.earth.x = [JSON[@"results"][@"earth"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.earth.y = [JSON[@"results"][@"earth"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.earth.z = [JSON[@"results"][@"earth"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.earth.graphDistance = [distances[@"earth"] integerValue];
                
                self.moon.name = @"moon";
                self.moon.x = [JSON[@"results"][@"moon"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.moon.y = [JSON[@"results"][@"moon"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.moon.z = [JSON[@"results"][@"moon"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.moon.graphDistance = [distances[@"moon"] integerValue];

                self.mars.name = @"mars";
                self.mars.x = [JSON[@"results"][@"mars"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.mars.y = [JSON[@"results"][@"mars"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.mars.z = [JSON[@"results"][@"mars"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.mars.graphDistance = [distances[@"mars"] integerValue];
                
                self.jupiter.name = @"jupiter";
                self.jupiter.x = [JSON[@"results"][@"jupiter"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.jupiter.y = [JSON[@"results"][@"jupiter"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.jupiter.z = [JSON[@"results"][@"jupiter"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.jupiter.graphDistance = [distances[@"jupiter"] integerValue];
                
                self.saturn.name = @"saturn";
                self.saturn.x = [JSON[@"results"][@"saturn"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.saturn.y = [JSON[@"results"][@"saturn"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.saturn.z = [JSON[@"results"][@"saturn"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.saturn.graphDistance = [distances[@"saturn"] integerValue];
                
                self.uranus.name = @"uranus";
                self.uranus.x = [JSON[@"results"][@"uranus"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.uranus.y = [JSON[@"results"][@"uranus"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.uranus.z = [JSON[@"results"][@"uranus"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.uranus.graphDistance = [distances[@"uranus"] integerValue];
                
                self.neptune.name = @"neptune";
                self.neptune.x = [JSON[@"results"][@"neptune"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.neptune.y = [JSON[@"results"][@"neptune"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.neptune.z = [JSON[@"results"][@"neptune"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.neptune.graphDistance = [distances[@"neptune"] integerValue];
                
                self.pluto.name = @"pluto";
                self.pluto.x = [JSON[@"results"][@"pluto"][0][0] doubleValue];
                //NSLog(@"NSError: %f",self.x);
                self.pluto.y = [JSON[@"results"][@"pluto"][0][1] doubleValue];
                //NSLog(@"NSError: %f",self.y);
                self.pluto.z = [JSON[@"results"][@"pluto"][0][2] doubleValue];
                //NSLog(@"NSError: %f",self.z);
                self.pluto.graphDistance = [distances[@"pluto"] integerValue];

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
