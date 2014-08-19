//
//  URLcheck.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/13/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "URLcheck.h"

@implementation URLcheck : NSObject

+(BOOL)canConnectTo:(NSString *)url
{
    /*
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil] ;
    BOOL canConnect = (URLString!= NULL) ? YES : NO;
    if (!canConnect){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Network Error", nil) message:[NSString  stringWithFormat:NSLocalizedString(@"Cannot reach %@",nil), url] delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss",nil) otherButtonTitles: nil];
        [alert show];
    }
    return canConnect;
     */
    return true;
}

@end
