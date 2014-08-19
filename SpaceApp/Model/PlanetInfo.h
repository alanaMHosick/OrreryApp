//
//  PlanetInfo.h
//  Space
//
//  Created by Alana Hosick on 1/30/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanetInfo : NSObject

+ (NSArray *) pictureArray;
+ (NSArray *) NASAPictureArray;
+ (NSArray *) NASAPictureArraySm;
+ (NSArray *) thumbnailBodyArray;
+ (NSArray *) bodyArray;

+ (NSString *) mercuryThumbnail;

+ (NSArray *) NASALargePictureArray;

+ (NSArray *) planetPictureCreditArray;

+ (NSArray *) bodyNameArray;

+ (NSString *) mercuryPicture;

+ (NSString *) mercuryButtonImage;

+ (NSDictionary *)distances:(NSString *)key;

+ (int)returnPlanetIndex:(NSString *)planetName;



@end
