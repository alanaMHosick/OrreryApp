//
//  Numbers.m
//  SpaceApp
//
//  Created by Alana Hosick on 3/1/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "Numbers.h"

@implementation Numbers

+(NSString *) formatStr:(NSString *)number Digits:(int)digits Decimals:(int)decimals
{
    NSString *locale = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@" LOCALE %@", locale);

    NSString *temp = [number stringByReplacingOccurrencesOfString:@"," withString:@","];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *myNumber = [f numberFromString:temp];
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:digits];
    [formatter setGroupingSize:3];
    [formatter setGroupingSeparator:@","];
    [formatter setUsesGroupingSeparator:YES];

    
    NSString *tempNum = [formatter stringFromNumber:myNumber];
    NSString *result = tempNum;
    NSString *num;
    
   /*    */
    //NSLog(@"%@", [currencyFormatter stringFromNumber:[NSNumber numberWithInt:10395209]]);
     NSString *decimal = [[number componentsSeparatedByString:@"."] lastObject];
    if([[temp componentsSeparatedByString:@"."] count]-1){
   
    NSLog(@"DECIMAL %@", decimal);
    
    
    
    if(decimal){
        
        NSNumber *d = [f numberFromString:decimal];
        //NSNumberFormatter* formatter = [NSNumberFormatter new];
        //[formatter setNumberStyle:NSNumberFormatterNoStyle];
       //// [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
        //[formatter setMinimumIntegerDigits:0];
        num = [formatter stringFromNumber:d];
        
        
            }
    }
    
    /*
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setUsesGroupingSeparator:YES];
    NSNumber *n = [numberFormatter numberFromString:result];
    result = [numberFormatter stringFromNumber:n];
    NSLog(@"RESULT %@", result);
    */
    if([[temp componentsSeparatedByString:@"."] count]-1){

    
        //decimal = [tempNum substringToIndex:decimals];
        result = [result stringByAppendingString:@"."];
        result = [result stringByAppendingString:num];
    }
    
    
    return result;

    
}
+(NSString *) formatDouble:(double)number Digits:(int)digits
{
    
    NSString *locale = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@" LOCALE %@", locale);
    NSString *num = [NSString stringWithFormat:@"%f",number];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:num];
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:digits];
    return [formatter stringFromNumber:myNumber];

}

+(NSString *) formatDate:(NSString *)date
{
    
    NSString *locale = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@" LOCALE %@", locale);
    NSLog(@" DATE %@", date);
    NSNumber *t;
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *year = [[date componentsSeparatedByString:@"-"] firstObject];
    NSString *yearplusColon = [NSString stringWithFormat:(@"%@-"),year];
    NSString *temp = [date stringByReplacingOccurrencesOfString:yearplusColon withString:@""];
    
    //NSString *temp = [[date componentsSeparatedByString:@"-"] lastObject];
    NSLog(@"%@",temp);
    NSString *month = [[temp componentsSeparatedByString:@"-"] firstObject];
    NSString *day = [[temp componentsSeparatedByString:@"-"] lastObject];
    
   
    t = [f numberFromString:year];
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:4];
    
    NSString *y = [formatter stringFromNumber:t];
    NSLog(@" Y %@", y);
    
    t = [f numberFromString:month];
    //NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:2];
    
    NSString *m = [formatter stringFromNumber:t];
    NSLog(@" M %@", m);
    
    t = [f numberFromString:day];
    //NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:2];
    
    NSString *d = [formatter stringFromNumber:t];
    NSLog(@" D %@", d);
    
    NSString *D = [y stringByAppendingString:@"/"];
    D = [D stringByAppendingString:m];
    D = [D stringByAppendingString:@"/"];
    D = [D stringByAppendingString:d];
    
    
    return D;
    
}

+(NSString *) formatTime:(NSString *)time
{
    
    NSString *locale = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@" LOCALE %@", locale);
    NSLog(@" TIME %@", time);
    NSNumber *t;
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *hours = [[time componentsSeparatedByString:@":"] firstObject];
    NSString *minutes = [[time componentsSeparatedByString:@":"] lastObject];
    
    
    t = [f numberFromString:hours];
    NSNumberFormatter* formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:1];
    
    NSString *h = [formatter stringFromNumber:t];
    NSLog(@" H %@", h);
    
    t = [f numberFromString:minutes];
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setMinimumIntegerDigits:2];
    
    NSString *m = [formatter stringFromNumber:t];
    NSLog(@" M %@", m);
    
    NSString *d = [formatter stringFromNumber:t];
    NSLog(@" D %@", d);
    
    NSString *D = [h stringByAppendingString:@":"];
    D = [D stringByAppendingString:m];
    
    return D;
    
}






@end
