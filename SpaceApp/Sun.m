//
//  Sun.m
//  Space
//
//  Created by Alana Hosick on 1/27/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//
#import "Sun.h"
#import "Math.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"


@implementation Sun

- (id)initSunLat:(long double)latitude Long:(long double)longitude Date:(NSDate *)date DST:(BOOL)dst
{
    self = [super init];
    
   
    self.longitude = longitude;
    self.latitude = latitude;
    self.dst = dst;
    
    NSString *day = [Math getDay:(NSDate *)date];
    NSString *month = [Math getMonth:(NSDate *)date];
    NSString *latitudeString = [NSString stringWithFormat:@"%Lf", latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%Lf", longitude];
    
    NSString *dstString;
    if (dst){
        dstString = @"1";
    }else{
        dstString = @"0";
    }
    NSString *path = [NSString stringWithFormat:@"/sun/%@/%@/%@/%@/99/%@",latitudeString, longitudeString, day, month, dstString];
    
    if(self) {
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.earthtools.org"]];
        
        NSMutableURLRequest *request =[httpClient requestWithMethod:@"GET" path:path parameters:nil];
        
        [request setCachePolicy:2];
        
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"Request successful");
            self.responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            //NSLog(@"Response: %@", self.responseString);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithHTTPFinishedLoading" object:nil];
        }failure:^(AFHTTPRequestOperation *operation, NSError *error){
            NSLog(@"Error: %@", error);
        }];
        [operation start];
    }
           
    return self;
}
        
@end

