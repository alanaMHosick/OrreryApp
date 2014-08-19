//
//  Screen.m
//  Space
//
//  Created by Alana Hosick on 1/30/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Screen.h"

@implementation Screen
+ (NSArray *)ViewerBackgroundImages
{
    return @[@"starrySkyLarge3.jpg",@"starrySkyMedium1.jpg",@"starrySkySmall3.jpg"];
}

+ (int)fitY:(int)y View:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    NSLog(@"y: %d", y);
    double differential = viewRectT.size.height / 480;
    return y * differential;
}

+ (int)fitX:(int)x View:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    NSLog(@"x: %d", x);
    double differential = viewRectT.size.width / 320;
    return x * differential;
}

+(double)radialMultiplierView:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    double diff = viewRectT.size.width / 320;
    return diff;
}

+(double)xCuriosityMultiplierView:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    double diff = viewRectT.size.width / 320;
    double difference = diff * 1.2;
    return difference;
}

+(double)yCuriosityMultiplierView:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    double diff = viewRectT.size.height / 480;
    return diff;
}

+ (int)fitOrreryY:(int)y View:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    NSLog(@"y: %d", y);
    if(viewRectT.size.height > 1000){
        double differential = (viewRectT.size.height / 480)/1;
        return y * differential;
    }else{
        return y;
    }
}

+ (int)fitOrreryX:(int)x View:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    NSLog(@"x: %d", x);
    if(viewRectT.size.height > 1000){
    double differential = (viewRectT.size.width / 320)/1;
    return x * differential;
    }else{
        return x;
    }
}


+ (int)sizePlanetButton:(int)size View:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    NSLog(@"top is %f tall and %f wide", viewRectT.size.height, viewRectT.size.width);
    
    if (viewRectT.size.height > 1000){
        return size * 3;
    }else{
        return size;
    }
    
}

+ (int)sizeBackground:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    if(viewRectT.size.height > 600){
        return 0;
    }else if (viewRectT.size.height > 500){
        return 1;
    }else {
        return 2;
    }
}

+(int)sizeFont:(int)font View:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    return font * viewRectT.size.width / 320;
}

/////////////////////////////////////////////// Curiosity ///////////////////////////////////////////////

+ (CGRect ) solLabelView:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,70,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,100,752,150);
        return rect;
    }
}

+ (CGRect ) atmosphereStringLabel1:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,180,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,360,752,150);
        return rect;
    }
}
+ (CGRect ) atmosphereStringLabel2:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,200,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,410,752,150);
        return rect;
    }
}
+ (CGRect ) atmosphereLabel:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,235,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,580,752,150);
        return rect;
    }
}

+ (CGRect ) lowTempLabel:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,340,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,700,752,150);
        return rect;
    }
}

+ (CGRect ) highTempLabel:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,360,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,750,752,150);
        return rect;
    }
}

+ (CGRect ) pressureLabel:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,380,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,800,752,150);
        return rect;
    }
}

+ (CGRect ) dateLabel:(UIView *)view
{
    CGRect viewRectT = [view bounds];
    CGRect rect;
    if (viewRectT.size.width == 320){
        rect = CGRectMake(12,400,280,40);
        return rect;
    }else{
        rect = CGRectMake(15,850,752,150);
        return rect;
    }
}


@end
