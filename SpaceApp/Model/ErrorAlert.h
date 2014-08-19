//
//  ErrorAlert.h
//  SpaceApp
//
//  Created by Alana Hosick on 2/23/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorAlert : NSObject

extern double lastError;
+ (void) errorAlert:(NSString *)error;
+ (void) inputErrorAlert:(NSString *)error;
@end
