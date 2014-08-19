//
//  PlanetInfo.m
//  Space
//
//  Created by Alana Hosick on 1/30/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "PlanetInfo.h"

@implementation PlanetInfo


+ (NSArray *) bodyArray
{
    return @[@"Sun", @"Mercury", @"Venus", @"Earth", @"Moon", @"Mars", @"Ceres", @"Jupiter", @"Saturn", @"Uranus", @"Neptune", @"Pluto", @"Eris"];
}

+ (NSArray *) bodyNameArray
{
    return @[@"sun", @"mercury", @"venus", @"earth", @"moon", @"mars", @"ceres", @"jupiter", @"saturn", @"uranus", @"neptune", @"pluto", @"eris"];
}


+ (NSArray *) thumbnailBodyArray
{
   return @[@"sun32", @"mercury-icon", @"venus-icon", @"earth2-icon", @"moon32", @"mars32-icon", @"ceres32", @"jupiter-icon", @"saturn32-icon", @"uranus-icon", @"neptune-icon", @"pluto32", @"eris23"];
}


+ (NSArray *) NASAPictureArray
{
    NSArray *NASAPictures = @[@"sunImage", @"mercuryImage", @"venusImage", @"earthImage", @"moonImage", @"marsImage", @"ceresImage", @"jupiterImage", @"saturnImage", @"uranusImage", @"neptuneImage", @"plutoImage2", @"erisImage"];
    return NASAPictures;
}
+ (NSArray *) NASAPictureArraySm
{
    NSArray *NASAPictures = @[@"sunImageSm", @"mercuryImageSm", @"venusImageSm", @"earthImageSm", @"moonImageSm", @"marsImageSm", @"ceresImageSm", @"jupiterImageSm", @"saturnImageSm", @"uranusImageSm", @"neptuneImageSm", @"plutoImageSm", @"erisImageSm"];
    return NASAPictures;
}
+ (NSArray *) planetPictureCreditArray
{
    NSArray *credits = @[@"NASA/European Space Agency", @"NASA/Johns Hopkins University Applied Physics Laboratory/Carnegie Institution of Washington", @"NASA/JPL", @"NASA", @"NASA/University of Arizona", @"ESA", @"NASA/ESA/SWRI/Cornell University/University of Maryland/STSci", @"NASA/JPL/University of Arizona", @"NASA/JPL/Space Science Institute", @"NASA/Space Telescope Science Institute", @"NASA", @"Dr. R. Albrecht, ESA/ESO Space Telescope European Coordinating Facility; NASA", @"NASA"];
    return credits;
}


+ (NSArray *) NASALargePictureArray
{
    NSArray *NASAPictures = @[@"sunPictureIPD", @"mercuryPicture2", @"venusPictureIPD", @"earthPictureIPD", @"moonPictureIPD", @"marsPictureIPD", @"ceresPictureIPD", @"jupiterPictureIPD", @"saturnPictureIPD", @"uranusPictureIPD", @"neptunePictureIPD", @"plutoPictureIPD", @"erisAndDysnomiaPictureIPD"];
    return NASAPictures;
}


+ (NSArray *) pictureArray
{
   return @[@"sun256", @"mercury256", @"venus256", @"earth256", @"moon256", @"mars256", @"ceres256", @"jupiter256", @"saturn256", @"uranus256", @"neptune256", @"pluto256", @"eris256"];
}
+ (NSDictionary *)distances:(NSString *)key
{
    NSDictionary *graphDistances = [[NSDictionary alloc] initWithObjectsAndKeys:@"30", @"mercury", @"45", @"venus", @"62", @"earth", @"80", @"mars", @"95", @"jupiter", @"110", @"saturn", @"130", @"uranus", @"155", @"neptune", nil];
    return graphDistances[key];
}

+ (int)returnPlanetIndex:(NSString *)planetName
{
    if ([planetName isEqualToString:@"sun"]){
        return 0;
    }
    if ([planetName isEqualToString:@"mercury"]){
        return 1;
    }
    if ([planetName isEqualToString:@"venus"]){
        return 2;
    }
    if ([planetName isEqualToString:@"earth"]){
        return 3;
    }
    if ([planetName isEqualToString:@"moon"]){
        return 4;
    }
    if ([planetName isEqualToString:@"mars"]){
        return 5;
    }
    if ([planetName isEqualToString:@"ceres"]){
        return 6;
    }
    if ([planetName isEqualToString:@"jupiter"]){
        return 7;
    }
    if ([planetName isEqualToString:@"saturn"]){
        return 8;
    }
    if ([planetName isEqualToString:@"uranus"]){
        return 9;
    }
    if ([planetName isEqualToString:@"neptune"]){
        return 10;
    }
    if ([planetName isEqualToString:@"pluto"]){
        return 11;
    }
    if ([planetName isEqualToString:@"eris"]){
        return 12;
    }
    else return 0;
}







+ (NSString *) mercuryThumbnail
{
    return @"mercury-icon.png";
}



+ (NSString *) mercuryPicture
{
    return @"mercury256";
}




+ (NSString *) mercuryButtonImage
{
    return @"mercury-icon.png";
}

@end
