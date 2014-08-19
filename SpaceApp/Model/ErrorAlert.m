//
//  ErrorAlert.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "ErrorAlert.h"
#import "Parser.h"

@implementation ErrorAlert

double lastError;

+ (void) errorAlert:(NSString *)error
{
   
    NSLog(@"error type: %@", [error class]);
        
        double currentError = [[NSDate date] timeIntervalSince1970];
        if (currentError - lastError > 2 || lastError == 0){
            
            
           // //NSString *temp = [[error componentsSeparatedByString:@"error = "] lastObject];
            //NSLog(@"temp value: %@", temp);
            //NSString *value = [[temp componentsSeparatedByString:endKey] firstObject];
           // NSLog(@"Parser value: %@", value);

            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[NSString  stringWithFormat:@"%@", error]
                          
                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss",nil) otherButtonTitles: nil];
            [alert show];
        }
        lastError = currentError;
    }

+ (void) inputErrorAlert:(NSString *)error
{
    
    NSLog(@"%@", error);
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[NSString  stringWithFormat:@"%@", error]
                              
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss",nil) otherButtonTitles: nil];
        [alert show];
    }


@end
