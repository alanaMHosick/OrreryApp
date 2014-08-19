//
//  UserLocation.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/21/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

// https://developers.google.com/maps/documentation/timezone/
// https://developers.google.com/maps/documentation/elevation/

#import "UserLocation.h"
#import "Math.h"
#import "AFJSONRequestOperation.h"
#import "Parser.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"


@implementation UserLocation


double userElevation;
int userTimezone;
BOOL dstBool;
NSString *timezoneName;



- (id)initUserLongitude:(double)longitude Latitude:(double)latitude
{
    self = [super init];
    
    self.longitude = longitude;
    self.latitude = latitude;
    
    userTimezone = 0;
    userElevation = 0;
    dstBool = NO;
    timezoneName = @"";
    
      if(self) {
          
          NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        
          NSString *searchTimezoneString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/timezone/json?location=%f,%f&timestamp=%f&sensor=true", latitude, longitude, timeStamp];
                                 
        NSLog(@" %@",searchTimezoneString);
        
        NSURL *url = [[NSURL alloc] initWithString:searchTimezoneString];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:2 timeoutInterval:100];
        
        AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSLog(@"%@", JSON);
            userTimezone = (int)([JSON[@"rawOffset"] integerValue] / 3600);
            int dstOffset = (int)([JSON[@"dstOffset"]integerValue] / 3600);
            if (dstOffset == 0){
                dstBool = NO;
            }else{
                dstBool = YES;
            }
            
            NSLog(@"timeZone: %d",userTimezone);
            NSLog(@"dst: %d",dstBool);
            NSLog(@"dstOffset: %d",dstOffset);
            
            timezoneName = JSON[@"timeZoneName"];
            NSLog(@"%@",timezoneName);
           
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJSON1FinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        [operation1 start];
        
      
          
          
         
//          // http://maps.googleapis.com/maps/api/elevation/json?locations=39.7391536,-104.9847034&sensor=true_or_false&key=API_KEY

          
          //NSString *searchElevationString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/elevation/json?locations=%f,%f&sensor=true", latitude, longitude];

          
          NSString *path = [NSString stringWithFormat:@"/maps/api/elevation/xml?locations=%f,%f&sensor=true", latitude, longitude];
          
          if(self) {
              
              AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://maps.googleapis.com"]];
              
              NSMutableURLRequest *request =[httpClient requestWithMethod:@"GET" path:path parameters:nil];
              
              [request setCachePolicy:2];
              
              AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
              
              [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
                  NSLog(@"Request successful");
                  NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSLog(@"Response: %@", responseString);
                  NSString *elevation = [Parser getValueForKey:(NSString *)@"elevation" inString:(NSString *)responseString];
                  userElevation = [elevation doubleValue];
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithHTTPFinishedLoading" object:nil];
              }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                  NSLog(@"Error: %@", error);
              }];
              [operation start];
          }
    }
    return self;
}



@end
