//
//  RADEC.m
//  SpaceApp
//
//  Created by Alana Hosick on 2/18/14.
//  Copyright (c) 2014 Alana Hosick. All rights reserved.
//

#import "RADEC.h"
#import "Planet.h"
#import "Math.h"

@implementation RADEC

+ (Planet *) riseSet:(Planet *)planet Earth:(Planet *)earth Star:(Planet *)sun Longitude:(double)geoLong Latitude:(double)geoLat Date:(NSDate *)date Timezone:(int)timezone Elevation:(double)elevation
{
    geoLong = geoLong * -1;
    planet = [Math findZenithPlanet:(Planet *)planet Earth:(Planet *)earth Sun:(Planet *)sun];
    
    
    double earthCenteredX = planet.x - earth.x;
    double earthCenteredY = planet.y - earth.y;
    //double earthCenteredZ = planet.z - earth.z;
    
    double polarAngle;
    
    
    int quadrant;
    if(earthCenteredX > 0 && earthCenteredY > 0){
        quadrant = 1;
        polarAngle = atan(earthCenteredY/earthCenteredX);
        NSLog(@"   ===  The polar coordinate of %@ is: %f", planet.name, polarAngle);
        
    }else if (earthCenteredX < 0 && earthCenteredY > 0){
        quadrant = 2;
        polarAngle = (atan(earthCenteredY/earthCenteredX) + 3.141593);
        NSLog(@"   ===  The polar coordinate of %@ is: %f", planet.name, polarAngle);
        
    }else if (earthCenteredX < 0 && earthCenteredY < 0){
        quadrant = 3;
        polarAngle = (atan(earthCenteredY/earthCenteredX) + 3.141593);
        NSLog(@"   ===  The polar coordinate of %@ is: %f", planet.name, polarAngle);
        
    }else{
        quadrant = 4;
        polarAngle = (atan(earthCenteredY/earthCenteredX) + (2*3.141593));
        NSLog(@"   ===  The polar coordinate of %@ is: %f", planet.name, polarAngle);
        
    }
    
    double h0;
    if([planet.name isEqualToString:(@"sun")]){
        h0 = -.8333;
    }else if([planet.name isEqualToString:(@"moon")]){
        h0 = .125;
    }else{
        h0 = .5667;
    }
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"g"];
    int JD = (int)[[dateFormatter stringFromDate:date] integerValue];
    
    NSLog(@" JD: %d", JD);
    
    long double T = (JD - 2451545.0)/36525;
    NSLog(@" T: %Lf", T);
    
    long double sideralTime = 100.46061837 + (36000.770053608 * T) + (.000387933 * T * T) - ((T * T * T)/38710000);
    NSLog(@" sideralTime: %Lf", sideralTime);
    
    while (sideralTime < 0){
        sideralTime = sideralTime + 360;
    }
    while (sideralTime > 360){
        sideralTime = sideralTime -360;
    }

    
    NSLog(@" sideral time: %Lf degrees", sideralTime);
    NSLog(@" polar angle: %f rad", polarAngle);

    //NSDictionary *yesterday = [self estimateRADECAngle:(double)(polarAngle - .025)];
    NSDictionary *today = [self estimateRADECAngle:(double)(polarAngle)];
    //NSDictionary *tomorrow = [self estimateRADECAngle:(double)(polarAngle + .01)];
    
    //double RA1 = [[yesterday objectForKey:@"RA"] doubleValue];
    //double DEC1 = [[yesterday objectForKey:@"DEC"] doubleValue];
    
    double RA2 = [[today objectForKey:@"RA"] doubleValue];
    double DEC2 = [[today objectForKey:@"DEC"] doubleValue];
    
    //double RA3 = [[tomorrow objectForKey:@"RA"] doubleValue];
    //double DEC3 = [[tomorrow objectForKey:@"DEC"] doubleValue];
    
    
    planet.RA = RA2;
    planet.DEC = DEC2;
    
    NSLog(@" RA: %f", RA2);
    NSLog(@" DEC: %f", DEC2);
    
    long double H0 = acos(  (  sin([self rad:h0]) - (sin([self rad:geoLat]) * sin([self rad:DEC2]))) / (cos([self rad:geoLat]) * cos([self rad:DEC2])));
    
    H0 = H0 * 57.2957795;
    NSLog(@" H0: %Lf", H0);
    
    long double m0 = (RA2 + geoLong - sideralTime)/360;  // transit
    while (m0 < 0){
        m0 = m0 + 1;
    }
    while (m0 > 1){
        m0 = m0 - 1;
    }
    
    double timeTransit = (m0 * 24) + timezone;
    
    if (timeTransit < 0){
       timeTransit = timeTransit + 24;
   }
    NSLog(@" TRANSIT: %f" , timeTransit);
    planet.transitTime = [self timeString:timeTransit];
    
    long double m1 = m0 - (H0 / 360);  // rise
    while (m1 < 0){
        m1 = m1 + 1;
    }
    while (m1 > 1){
        m1 = m1 - 1;
    }
    double timeRise = (m1 * 24) + timezone;
    if (timeRise < 0){
        timeRise = timeRise + 24;
   }
    NSLog(@" RISE: %f" , timeRise);
    planet.riseTime = [self timeString:timeRise];

    
    long double m2 = m0 + (H0 / 360);  //set
    while (m2 < 0){
        m2 = m2 + 1;
    }
    while (m2 > 1){
        m2 = m2 - 1;
    }
    double timeSet = (m2 * 24) + timezone;
    if (timeSet < 0){
        timeSet = timeSet + 24;
    }
    NSLog(@" SET: %f" , timeSet);
    planet.setTime = [self timeString:timeSet];

    
    long double STGTransit = sideralTime + (360.985647 * m0);
    long double STGRising = sideralTime + (360.985647 * m1);
    long double STGSetting = sideralTime + (360.985647 * m2);
    
    
    
    //int deltaT = [self getDeltaT];
    
    // find time  // interpolate
    
    //Local hour
    
    long double localhourTransit = (STGTransit - geoLong - RA2);
    NSLog(@" transit: %Lf", localhourTransit);

    //correct for height
    
    long double localHourRise = (STGRising - geoLong - RA2);
    NSLog(@" rise: %Lf", localHourRise);
    
    long double localHourSet = (STGSetting - geoLong - RA2);
    NSLog(@" set: %Lf", localHourSet);
    
    
    return planet;
}

+ (NSString *) timeString:(double)hours
{
    float integerPortion = floor(hours);
    float decimalPortion = hours - integerPortion;
    decimalPortion = decimalPortion * 60;
    NSLog(@"decimal portion: %f", decimalPortion);
    NSString *minutes;
    if(decimalPortion < 10){
        minutes = [NSString stringWithFormat:@"0%.f",decimalPortion];
    }else{
        minutes = [NSString stringWithFormat:@"%.f",decimalPortion];
    }
    
    NSString *timeString = [NSString stringWithFormat:@"%.0f:%@", integerPortion, minutes];
    NSLog(@"timeString: %@", timeString);
    return timeString;
}

+ (int) getDeltaT
{
    return 65;
}

+ (long double)rad:(long double)degrees
{
    return degrees * 0.0174532925;
}



+ (NSMutableDictionary *) estimateRADECAngle:(double)angle
{
   
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
         
    
    NSLog(@" looking for angle: %f", angle);
    
   
    
    
    /////////////////////////////////   SEP   //////////////////////////////////
    
   
     
     //SEP 1
     if(angle > 2.779586 && angle <= 2.795428){
        [dict setObject:[NSNumber numberWithDouble:161.025] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:8.0219] forKey:@"DEC"];
        NSLog(@" sep 1: %f", angle);
     }
     //SEP 2
     else if(angle > 2.795428 && angle <= 2.807310){
        [dict setObject:[NSNumber numberWithDouble:161.934] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:7.6565] forKey:@"DEC"];
        NSLog(@" sep 2: %f", angle);
     }
     //SEP 3
     else if(angle > 2.807310 && angle <= 2.823111){
        [dict setObject:[NSNumber numberWithDouble:162.834] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:7.2903] forKey:@"DEC"];
        NSLog(@" sep 3: %f", angle);
     }
     //SEP 4
     else if(angle > 2.823111 && angle <= 2.854651){
        [dict setObject:[NSNumber numberWithDouble:163.737] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:6.9206] forKey:@"DEC"];
        NSLog(@" sep 4: %f", angle);
     }
     //SEP 5
     else if(angle > 2.854651 && angle <= 2.854651){
        [dict setObject:[NSNumber numberWithDouble:164.6415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:6.5492] forKey:@"DEC"];
        NSLog(@" sep 5: %f", angle);
     }
     //SEP 6
     else if(angle > 2.854651 && angle <= 2.870392){
        [dict setObject:[NSNumber numberWithDouble:165.5415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:6.1775] forKey:@"DEC"];
        NSLog(@" sep 6: %f", angle);
     }
     //SEP 7
     else if(angle > 2.870392 && angle <= 2.886116){
        [dict setObject:[NSNumber numberWithDouble:166.4415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:5.8025] forKey:@"DEC"];
        NSLog(@" sep 7: %f", angle);
     }
     //SEP 8
     else if(angle > 2.886116 && angle <= 2.901825){
        [dict setObject:[NSNumber numberWithDouble:167.346] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:5.4258] forKey:@"DEC"];
        NSLog(@" sep 8: %f", angle);
     }
     //SEP 9
     else if(angle > 2.901825 && angle <= 2.917520){
        [dict setObject:[NSNumber numberWithDouble:168.2415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:5.0494] forKey:@"DEC"];
        NSLog(@" sep 9: %f", angle);
     }
     //SEP 10
     else if(angle > 2.917520 && angle <= 2.933204){
        [dict setObject:[NSNumber numberWithDouble:169.1415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:4.6697] forKey:@"DEC"];
        NSLog(@" sep 10: %f", angle);
     }
     //SEP 11
     else if(angle > 2.933204 && angle <= 2.948877){
        [dict setObject:[NSNumber numberWithDouble:170.0415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:4.2889] forKey:@"DEC"];
        NSLog(@" sep 11: %f", angle);
     }
     //SEP 12
     else if(angle > 2.948877 && angle <= 2.964541){
        [dict setObject:[NSNumber numberWithDouble:170.934] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:3.9083] forKey:@"DEC"];
        NSLog(@" sep 12: %f", angle);
     }
     //SEP 13
    else if(angle > 2.964541 && angle <= 2.980199){
        [dict setObject:[NSNumber numberWithDouble:171.834] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:3.525] forKey:@"DEC"];
        NSLog(@" sep 13: %f", angle);
     }
     //SEP 14
     else if(angle > 2.980199 && angle <= 2.995851){
        [dict setObject:[NSNumber numberWithDouble:172.7295] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:3.1406] forKey:@"DEC"];
        NSLog(@" sep 14: %f", angle);
     }
     //SEP 15
     else if(angle > 2.995851 && angle <= 3.011500){
        [dict setObject:[NSNumber numberWithDouble:173.625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:2.7569] forKey:@"DEC"];
        NSLog(@" sep 15: %f", angle);
     }
     //SEP 16
     else if(angle > 3.011500 && angle <=3.027147 ){
        [dict setObject:[NSNumber numberWithDouble:174.5205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:2.3706] forKey:@"DEC"];
        NSLog(@" sep 16: %f", angle);
     }
     //SEP 17
     else if(angle > 3.027147 && angle <= 3.042793 ){
        [dict setObject:[NSNumber numberWithDouble:175.05] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:1.9836] forKey:@"DEC"];
        NSLog(@" sep 17: %f", angle);
     }
     //SEP 18
     else if(angle > 3.042793 && angle <= 3.058439){
        [dict setObject:[NSNumber numberWithDouble:176.313] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:1.5975] forKey:@"DEC"];
        NSLog(@" sep 18: %f", angle);
     }
     //SEP 19
     else if(angle > 3.058439 && angle <= 3.074088){
        [dict setObject:[NSNumber numberWithDouble:177.2085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:1.2092] forKey:@"DEC"];
        NSLog(@" sep 19: %f", angle);
     }
     //SEP 20
     else if(angle > 3.074088 && angle <= 3.089739){
        [dict setObject:[NSNumber numberWithDouble:178.1085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:0.8203] forKey:@"DEC"];
        NSLog(@" sep 20: %f", angle);
     }
    //SEP 21
    else if(angle > 3.089739 && angle <= 3.106174){
        [dict setObject:[NSNumber numberWithDouble:178.9995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:0.4328] forKey:@"DEC"];
        NSLog(@" sep 21: %f", angle);
    }
    //SEP 22
    else if(angle > 3.106174 && angle <= 3.121825){
        [dict setObject:[NSNumber numberWithDouble:179.8995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:0.0433] forKey:@"DEC"];
        NSLog(@" sep 22: %f", angle);
    }
    //SEP 23
    else if(angle > 3.121825 && angle <= 3.137480){
        [dict setObject:[NSNumber numberWithDouble:180.7995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-0.3467] forKey:@"DEC"];
        NSLog(@" sep 23: %f", angle);
    }
    //SEP 24
    else if(angle > 3.137480 && angle <=  3.152407 ){
        [dict setObject:[NSNumber numberWithDouble:181.6965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-0.735] forKey:@"DEC"];
        NSLog(@" sep 24: %f", angle);
    }
    //SEP 25
    else if(angle >  3.152407 && angle <= 3.168095 ){
      [dict setObject:[NSNumber numberWithDouble:182.5965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-1.1247] forKey:@"DEC"];
        NSLog(@" sep 25: %f", angle);
  }
    //SEP 26
    else if(angle > 3.168095 && angle <= 3.183795){
        [dict setObject:[NSNumber numberWithDouble:183.4965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-1.5147] forKey:@"DEC"];
        NSLog(@" sep 26: %f", angle);
    }
    //SEP 27
    else if(angle > 3.183795 && angle <= 3.199507){
        [dict setObject:[NSNumber numberWithDouble:184.3965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-1.9028] forKey:@"DEC"];
        NSLog(@" sep 27: %f", angle);
    }
    //SEP 28
    else if(angle > 3.199507 && angle <= 3.215232){
        [dict setObject:[NSNumber numberWithDouble:185.2995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-2.2925] forKey:@"DEC"];
        NSLog(@" sep 28: %f", angle);
    }
    //SEP 29
    else if(angle > 3.215232 && angle <= 3.230972){
        [dict setObject:[NSNumber numberWithDouble:186.204] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-2.6817] forKey:@"DEC"];
        NSLog(@" sep 29: %f", angle);
    }
    //SEP 30
    else if(angle > 3.230972 && angle <= 3.246728){
        [dict setObject:[NSNumber numberWithDouble:187.104] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-3.0686] forKey:@"DEC"];
        NSLog(@" sep 30: %f", angle);
    }

  
/////////////////////////////////   OCT   //////////////////////////////////


  
    //OCT 1
    else if(angle > 3.246728 && angle <= 3.266454){
        [dict setObject:[NSNumber numberWithDouble:188.0085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-3.4569] forKey:@"DEC"];
        NSLog(@" oct 1: %f", angle);
    }
    //OCT 2
    else if(angle > 3.266454 && angle <= 3.278295){
        [dict setObject:[NSNumber numberWithDouble:188.916] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-3.8444] forKey:@"DEC"];
        NSLog(@" oct 2: %f", angle);
    }
    //OCT 3
    else if(angle > 3.278295 && angle <= 3.294107){
        [dict setObject:[NSNumber numberWithDouble:189.825] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-4.2294] forKey:@"DEC"];
        NSLog(@" oct 3: %f", angle);
    }
    //OCT 4
    else if(angle > 3.294107 && angle <= 3.309942){
        [dict setObject:[NSNumber numberWithDouble:190.734] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-4.6156] forKey:@"DEC"];
        NSLog(@" oct 4: %f", angle);
    }
    //OCT 5
    else if(angle > 3.309942 && angle <= 3.325800){
        [dict setObject:[NSNumber numberWithDouble:191.646] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-5.0006] forKey:@"DEC"];
        NSLog(@" oct 5: %f", angle);
    }
    //OCT 6
    else if(angle > 3.325800 && angle <= 3.341682){
        [dict setObject:[NSNumber numberWithDouble:192.558] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-5.3828] forKey:@"DEC"];
        NSLog(@" oct 6: %f", angle);
    }
    //OCT 7
    else if(angle > 3.341682 && angle <= 3.357591){
        [dict setObject:[NSNumber numberWithDouble:193.4715] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-5.7658] forKey:@"DEC"];
        NSLog(@" oct 7: %f", angle);
    }
    //OCT 8
    else if(angle > 3.357591 && angle <= 3.373529){
        [dict setObject:[NSNumber numberWithDouble:194.388] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-6.1472] forKey:@"DEC"];
        NSLog(@" oct 8: %f", angle);
    }
    //OCT 9
    else if(angle > 3.373529 && angle <= 3.389497){
        [dict setObject:[NSNumber numberWithDouble:195.3045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-6.5258] forKey:@"DEC"];
        NSLog(@" oct 9: %f", angle);
    }
    //OCT 10
    else if(angle > 3.389497 && angle <= 3.405496){
        [dict setObject:[NSNumber numberWithDouble:196.2255] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-6.9547] forKey:@"DEC"];
        NSLog(@" oct 10: %f", angle);
    }
    //OCT 11
    else if(angle > 3.405496 && angle <= 3.421530){
        [dict setObject:[NSNumber numberWithDouble:197.1465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-7.2819] forKey:@"DEC"];
        NSLog(@" oct 11: %f", angle);
    }
    //OCT 12
    else if(angle > 3.421530 && angle <= 3.437598){
        [dict setObject:[NSNumber numberWithDouble:198.006] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-7.6561] forKey:@"DEC"];
        NSLog(@" oct 12: %f", angle);
    }
    //OCT 13
    else if(angle > 3.437598 && angle <= 3.453704){
        [dict setObject:[NSNumber numberWithDouble:198.996] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-8.03] forKey:@"DEC"];
        NSLog(@" oct 13: %f", angle);
    }
    //OCT 14
    else if(angle > 3.453704 && angle <= 3.469848){
        [dict setObject:[NSNumber numberWithDouble:199.9245] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-8.4019] forKey:@"DEC"];
        NSLog(@" oct 14: %f", angle);
    }
    //OCT 15
    else if(angle > 3.469848 && angle <= 3.490210){
        [dict setObject:[NSNumber numberWithDouble:200.48] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-8.7703] forKey:@"DEC"];
        NSLog(@" oct 15: %f", angle);
    }
    //OCT 16
    else if(angle > 3.490210 && angle <= 3.506442){
        [dict setObject:[NSNumber numberWithDouble:201.783] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-9.1383] forKey:@"DEC"];
        NSLog(@" oct 16: %f", angle);
    }
    //OCT 17
    else if(angle > 3.506442 && angle <= 3.522716){
        [dict setObject:[NSNumber numberWithDouble:202.7205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-9.5042] forKey:@"DEC"];
        NSLog(@" oct 17: %f", angle);
    }
    //OCT 18
    else if(angle > 3.522716 && angle <= 3.539031){
        [dict setObject:[NSNumber numberWithDouble:203.6535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-9.8661] forKey:@"DEC"];
        NSLog(@" oct 18: %f", angle);
    }
    //OCT 19
    else if(angle > 3.539031 && angle <= 3.555390){
        [dict setObject:[NSNumber numberWithDouble:204.6397] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-10.2269] forKey:@"DEC"];
        NSLog(@" oct 19: %f", angle);
    }
    //OCT 20
    else if(angle > 3.571795 && angle <= 3.571795){
        [dict setObject:[NSNumber numberWithDouble:205.5375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-10.5856] forKey:@"DEC"];
        NSLog(@" oct 20: %f", angle);
    }
    //OCT 21
    else if(angle > 3.571795 && angle <= 3.588246){
        [dict setObject:[NSNumber numberWithDouble:206.484] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-10.94] forKey:@"DEC"];
        NSLog(@" oct 21: %f", angle);
    }
    //OCT 22
    else if(angle > 3.588246 && angle <= 3.604745){
        [dict setObject:[NSNumber numberWithDouble:207.429] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-11.2933] forKey:@"DEC"];
        NSLog(@" oct 22: %f", angle);
    }
    //OCT 23
    else if(angle > 3.604745 && angle <= 3.617088){
        [dict setObject:[NSNumber numberWithDouble:208.383] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-11.6439] forKey:@"DEC"];
        NSLog(@" oct 23: %f", angle);
    }
    //OCT 24
    else if(angle > 3.617088 && angle <= 3.633684){
        [dict setObject:[NSNumber numberWithDouble:209.334] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-11.9897] forKey:@"DEC"];
        NSLog(@" oct 24: %f", angle);
    }
    //OCT 25
    else if(angle > 3.633684 && angle <= 3.650331){
        [dict setObject:[NSNumber numberWithDouble:210.291] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-12.3342] forKey:@"DEC"];
        NSLog(@" oct 25: %f", angle);
    }
    //OCT 26
    else if(angle > 3.650331 && angle <= 3.667029){
        [dict setObject:[NSNumber numberWithDouble:211.254] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-12.6756] forKey:@"DEC"];
        NSLog(@" oct 26: %f", angle);
    }
    //OCT 27
    else if(angle > 3.667029 && angle <= 3.683779){
        [dict setObject:[NSNumber numberWithDouble:212.2125] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-13.0119] forKey:@"DEC"];
        NSLog(@" oct 27: %f", angle);
    }
    //OCT 28
    else if(angle > 3.683779 && angle <= 3.700582){
        [dict setObject:[NSNumber numberWithDouble:213.183] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-13.3467] forKey:@"DEC"];
        NSLog(@" oct 28: %f", angle);
    }
    //OCT 29
    else if(angle > 3.700582 && angle <= 3.717439){
        [dict setObject:[NSNumber numberWithDouble:214.1535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-13.6778] forKey:@"DEC"];
        NSLog(@" oct 29: %f", angle);
    }
    //OCT 30
    else if(angle > 3.717439 && angle <= 3.734349){
        [dict setObject:[NSNumber numberWithDouble:215.121] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.0036] forKey:@"DEC"];
        NSLog(@" oct 30: %f", angle);
    }
    //OCT 31
    else if(angle > 3.734349 && angle <= 3.755603){
        [dict setObject:[NSNumber numberWithDouble:216.1005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.3275] forKey:@"DEC"];
        NSLog(@" oct 31: %f", angle);
    }
    


    
/////////////////////////////////   NOV   //////////////////////////////////
    
    
    //NOV 1
    else if(angle > 3.755603 && angle <= 3.768315){
        [dict setObject:[NSNumber numberWithDouble:217.0785] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.6475] forKey:@"DEC"];
        NSLog(@" nov 1: %f", angle);
    }
    //NOV 2
    else if(angle > 3.768315 && angle <= 3.785365){
        [dict setObject:[NSNumber numberWithDouble:218.1045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.9619] forKey:@"DEC"];
        NSLog(@" nov 2: %f", angle);
    }
    //NOV 3
    else if(angle > 3.785365 && angle <= 3.802471){
        [dict setObject:[NSNumber numberWithDouble:219.0495] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-15.2739] forKey:@"DEC"];
        NSLog(@" nov 3: %f", angle);
    }
    //NOV 4
    else if(angle > 3.802471 && angle <= 3.819635){
        [dict setObject:[NSNumber numberWithDouble:220.041] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-15.5817] forKey:@"DEC"];
        NSLog(@" nov 4: %f", angle);
    }
    //NOV 5
    else if(angle > 3.819635 && angle <= 3.836856){
        [dict setObject:[NSNumber numberWithDouble:221.0295] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-15.8839] forKey:@"DEC"];
        NSLog(@" nov 5: %f", angle);
    }
    //NOV 6
    else if(angle > 3.836856 && angle <= 3.854137){
        [dict setObject:[NSNumber numberWithDouble:222.0285] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.1828] forKey:@"DEC"];
        NSLog(@" nov 6: %f", angle);
    }
    //NOV 7
    else if(angle > 3.854137 && angle <= 3.871477){
        [dict setObject:[NSNumber numberWithDouble:223.029] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.4775] forKey:@"DEC"];
        NSLog(@" nov 7: %f", angle);
    }
    //NOV 8
    else if(angle > 3.871477 && angle <= 3.888878){
        [dict setObject:[NSNumber numberWithDouble:224.0295] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.7661] forKey:@"DEC"];
        NSLog(@" nov 8: %f", angle);
    }
    //NOV 9
    else if(angle > 3.888878 && angle <= 3.906340){
        [dict setObject:[NSNumber numberWithDouble:225.0375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.0514] forKey:@"DEC"];
        NSLog(@" nov 9: %f", angle);
    }
    //NOV 10
    else if(angle > 3.906340 && angle <= 3.923864){
        [dict setObject:[NSNumber numberWithDouble:226.05] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.3317] forKey:@"DEC"];
        NSLog(@" nov 10: %f", angle);
    }
    //NOV 11
    else if(angle > 3.923864 && angle <= 3.941450){
        [dict setObject:[NSNumber numberWithDouble:227.0625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.6058] forKey:@"DEC"];
        NSLog(@" nov 11: %f", angle);
    }
    //NOV 12
    else if(angle > 3.941450 && angle <= 3.959098){
        [dict setObject:[NSNumber numberWithDouble:228.0795] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.8761]forKey:@"DEC"];
        NSLog(@" nov 12: %f", angle);
    }
    //NOV 13
    else if(angle > 3.959098 && angle <= 3.976809){
        [dict setObject:[NSNumber numberWithDouble:229.104] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.1411] forKey:@"DEC"];
        NSLog(@" nov 13: %f", angle);
    }
    //NOV 14
    else if(angle > 3.976809 && angle <= 3.994582){
        [dict setObject:[NSNumber numberWithDouble:230.1255] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.400] forKey:@"DEC"];
        NSLog(@" nov 14: %f", angle);
    }
    //NOV 15
    else if(angle > 3.994582 && angle <= 4.012419){
        [dict setObject:[NSNumber numberWithDouble:231.1545] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.6542] forKey:@"DEC"];
        NSLog(@" nov 15: %f", angle);
    }
    //NOV 16
    else if(angle > 4.012419 && angle <= 4.030308){
        [dict setObject:[NSNumber numberWithDouble:232.1835] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.9033] forKey:@"DEC"];
        NSLog(@" nov 16: %f", angle);
    }
    //NOV 17
    else if(angle > 4.030308 && angle <= 4.048269){
        [dict setObject:[NSNumber numberWithDouble:233.217] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.1456] forKey:@"DEC"];
        NSLog(@" nov 17: %f", angle);
    }
    //NOV 18
    else if(angle > 4.048269 && angle <= 4.066292){
        [dict setObject:[NSNumber numberWithDouble:234.258] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.3831] forKey:@"DEC"];
        NSLog(@" nov 18: %f", angle);
    }
    //NOV 19
    else if(angle > 4.066292 && angle <= 4.084385){
        [dict setObject:[NSNumber numberWithDouble:235.3005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.6147] forKey:@"DEC"];
        NSLog(@" nov 19: %f", angle);
    }
    //NOV 20
    else if(angle > 4.084385 && angle <= 4.102530){
        [dict setObject:[NSNumber numberWithDouble:236.3415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.8397] forKey:@"DEC"];
        NSLog(@" nov 20: %f", angle);
    }
    //NOV 21
    else if(angle > 4.102530 && angle <= 4.120735){
        [dict setObject:[NSNumber numberWithDouble:237.3915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.0594] forKey:@"DEC"];
        NSLog(@" nov 21: %f", angle);
    }
    //NOV 22
    else if(angle > 4.120735 && angle <= 4.138999){
        [dict setObject:[NSNumber numberWithDouble:238.446] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.2733] forKey:@"DEC"];
        NSLog(@" nov 22: %f", angle);
    }
    //NOV 23
    else if(angle > 4.138999 && angle <= 4.157321){
        [dict setObject:[NSNumber numberWithDouble:239.496] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.4797] forKey:@"DEC"];
        NSLog(@" nov 23: %f", angle);
    }
    //NOV 24
    else if(angle > 4.157321 && angle <= 4.175700){
        [dict setObject:[NSNumber numberWithDouble:240.5535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.6808] forKey:@"DEC"];
        NSLog(@" nov 24: %f", angle);
    }
    //NOV 25
    else if(angle > 4.175700 && angle <= 4.194135){
        [dict setObject:[NSNumber numberWithDouble:241.6215] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.8756] forKey:@"DEC"];
        NSLog(@" nov 25: %f", angle);
    }
    //NOV 26
    else if(angle > 4.194135 && angle <= 4.212624){
        [dict setObject:[NSNumber numberWithDouble:242.697] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.0631] forKey:@"DEC"];
        NSLog(@" nov 26: %f", angle);
    }
    //NOV 27
    else if(angle > 4.212624 && angle <= 4.231166){
        [dict setObject:[NSNumber numberWithDouble:243.75] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.2447] forKey:@"DEC"];
        NSLog(@" nov 27: %f", angle);
    }
    //NOV 28
    else if(angle > 4.231166 && angle <= 4.249760){
        [dict setObject:[NSNumber numberWithDouble:244.821] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.4197] forKey:@"DEC"];
        NSLog(@" nov 28: %f", angle);
    }
    //NOV 29
    else if(angle > 4.249760 && angle <= 4.268404){
        [dict setObject:[NSNumber numberWithDouble:245.892] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.5872] forKey:@"DEC"];
        NSLog(@" nov 29: %f", angle);
    }
    //NOV 30
    else if(angle > 4.268404 && angle <= 4.287097){
        [dict setObject:[NSNumber numberWithDouble:246.891] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.7483] forKey:@"DEC"];
        NSLog(@" nov 30: %f", angle);
    }
  
    
///////////////////////////////   DEC  //////////////////////////////////
    
    //DEC 1
    else if(angle > 4.287097 && angle <= 4.305824){
        [dict setObject:[NSNumber numberWithDouble:248.0535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.9028] forKey:@"DEC"];
        NSLog(@" dec 1: %f", angle);
    }
    //DEC 2
    else if(angle > 4.305824 && angle <= 4.324611){
        [dict setObject:[NSNumber numberWithDouble:249.1335] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.0494] forKey:@"DEC"];
        NSLog(@" dec 2: %f", angle);
    }
    //DEC 3
    else if(angle > 4.324611 && angle <= 4.343442){
        [dict setObject:[NSNumber numberWithDouble:250.2165] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.1897] forKey:@"DEC"];
        NSLog(@" dec 3: %f", angle);
    }
    //DEC 4
    else if(angle > 4.343442 && angle <= 4.362317){
        [dict setObject:[NSNumber numberWithDouble:251.3085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.3231] forKey:@"DEC"];
        NSLog(@" dec 4: %f", angle);
    }
    //DEC 5
    else if(angle > 4.362317 && angle <= 4.381234){
        [dict setObject:[NSNumber numberWithDouble:252.3915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.4483] forKey:@"DEC"];
        NSLog(@" dec 5: %f", angle);
    }
    //DEC 6
    else if(angle > 4.381234 && angle <= 4.400192){
        [dict setObject:[NSNumber numberWithDouble:253.488] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.5669] forKey:@"DEC"];
        NSLog(@" dec 6: %f", angle);
    }
    //DEC 7
    else if(angle > 4.400192 && angle <= 4.419189){
        [dict setObject:[NSNumber numberWithDouble:254.5785] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.6781] forKey:@"DEC"];
        NSLog(@" dec 7: %f", angle);
    }
    //DEC 8
    else if(angle > 4.419189 && angle <= 4.438224){
        [dict setObject:[NSNumber numberWithDouble:255.675] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.7814] forKey:@"DEC"];
        NSLog(@" dec 8: %f", angle);
    }
    //DEC 9
    else if(angle > 4.438224 && angle <= 4.457295){
        [dict setObject:[NSNumber numberWithDouble:256.7715] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.8778] forKey:@"DEC"];
        NSLog(@" dec 9: %f", angle);
    }
    //DEC 10
    else if(angle > 4.457295 && angle <= 4.476400){
        [dict setObject:[NSNumber numberWithDouble:257.8755] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.9667] forKey:@"DEC"];
        NSLog(@" dec 10: %f", angle);
    }
    //DEC 11
    else if(angle > 4.476400 && angle <= 4.495538){
        [dict setObject:[NSNumber numberWithDouble:258.9705] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.0475] forKey:@"DEC"];
        NSLog(@" dec 11: %f", angle);
    }
    //DEC 12
    else if(angle > 4.495538 && angle <= 4.514706){
        [dict setObject:[NSNumber numberWithDouble:260.0745] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.1211] forKey:@"DEC"];
        NSLog(@" dec 12: %f", angle);
    }
    //DEC 13
    else if(angle > 4.514706 && angle <= 4.533902){
        [dict setObject:[NSNumber numberWithDouble:261.1785] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.1872] forKey:@"DEC"];
        NSLog(@" dec 13: %f", angle);
    }
    //DEC 14
    else if(angle > 4.533902 && angle <= 4.553125){
        [dict setObject:[NSNumber numberWithDouble:262.2795] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.245] forKey:@"DEC"];
        NSLog(@" dec 14: %f", angle);
    }
    //DEC 15
    else if(angle > 4.553125 && angle <= 4.572372){
        [dict setObject:[NSNumber numberWithDouble:263.388] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.2956] forKey:@"DEC"];
        NSLog(@" dec 15: %f", angle);
    }
    //DEC 16
    else if(angle > 4.572372 && angle <= 4.591641){
        [dict setObject:[NSNumber numberWithDouble:264.4965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.3383] forKey:@"DEC"];
        NSLog(@" dec 16: %f", angle);
    }
    //DEC 17
    else if(angle > 4.591641 && angle <= 4.610929){
        [dict setObject:[NSNumber numberWithDouble:265.6005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.3731] forKey:@"DEC"];
        NSLog(@" dec 17: %f", angle);
    }
    //DEC 18
    else if(angle > 4.610929 && angle <=  4.630235){
        [dict setObject:[NSNumber numberWithDouble:266.709] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.4003] forKey:@"DEC"];
        NSLog(@" dec 18: %f", angle);
    }

    //DEC 19
    else if(angle >  4.630235 && angle <= 4.649542){
        [dict setObject:[NSNumber numberWithDouble:267.8205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.4197] forKey:@"DEC"];
        NSLog(@" dec 19: %f", angle);
    }
    //DEC 20
    else if(angle > 4.649542 && angle <= 4.668874){
        [dict setObject:[NSNumber numberWithDouble:268.9245] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.4311] forKey:@"DEC"];
        NSLog(@" dec 20: %f", angle);
    }
    //DEC 21
    else if(angle > 4.668874 && angle <= 4.688227){
        [dict setObject:[NSNumber numberWithDouble:270.0375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.4347] forKey:@"DEC"];
        NSLog(@" dec 21: %f", angle);
    }
    //DEC 22
    else if(angle > 4.688227 && angle <= 4.707574){
        [dict setObject:[NSNumber numberWithDouble:271.1505] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.4306] forKey:@"DEC"];
        NSLog(@" dec 22: %f", angle);
    }
    //DEC 23
    else if(angle > 4.707574 && angle <= 4.726925){
        [dict setObject:[NSNumber numberWithDouble:272.2545] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.4183] forKey:@"DEC"];
        NSLog(@" dec 23: %f", angle);
    }
    //DEC 24
    else if(angle > 4.726925 && angle <= 4.746277){
        [dict setObject:[NSNumber numberWithDouble:273.366] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.3986] forKey:@"DEC"];
        NSLog(@" dec 24: %f", angle);
    }
    //DEC 25
    else if(angle > 4.746277 && angle <= 4.765626 ){
        [dict setObject:[NSNumber numberWithDouble:274.479] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.3706] forKey:@"DEC"];
        NSLog(@" dec 25: %f", angle);
    }
    //DEC 26
    else if(angle >  4.765626 && angle <= 4.784970){
        [dict setObject:[NSNumber numberWithDouble:275.583] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.3353] forKey:@"DEC"];
        NSLog(@" dec 26: %f", angle);
    }
    //DEC 27
    else if(angle > 4.784970 && angle <= 4.804306){
        [dict setObject:[NSNumber numberWithDouble:276.696] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.2917] forKey:@"DEC"];
        NSLog(@" dec 27: %f", angle);
    }
    //DEC 28
    else if(angle > 4.804306 && angle <= 4.823632){
        [dict setObject:[NSNumber numberWithDouble:277.8045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.2406] forKey:@"DEC"];
        NSLog(@" dec 28: %f", angle);
    }
    //DEC 29
    else if(angle > 4.823632 && angle <= 4.842945){
        [dict setObject:[NSNumber numberWithDouble:278.9085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.1817] forKey:@"DEC"];
        NSLog(@" dec 29: %f", angle);
    }
    //DEC 30
    else if(angle > 4.842945 && angle <= 4.862243){
        [dict setObject:[NSNumber numberWithDouble:280.017] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.115] forKey:@"DEC"];
        NSLog(@" dec 30: %f", angle);
    }
    //DEC 31
    else if(angle > 4.862243 && angle <= 4.881523){
        [dict setObject:[NSNumber numberWithDouble:281.121] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-23.0406] forKey:@"DEC"];
        NSLog(@" dec 31: %f", angle);
    }

    

    
    
/////////////////////////////////////////////  JAN  //////////////////////////////////////////
    
    //JAN 1
    else if(angle > 4.881523 && angle <= 4.908017){
        [dict setObject:[NSNumber numberWithDouble:282.4965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.9381] forKey:@"DEC"];
        NSLog(@" jan 1: %f", angle);
    }
    //JAN 2
    else if(angle > 4.908017 && angle <= 4.927279){
        [dict setObject:[NSNumber numberWithDouble:283.596] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.8467] forKey:@"DEC"];
        NSLog(@" jan 2: %f", angle);
    }
    //JAN 3
    else if(angle > 4.927279 && angle <= 4.946517){
        [dict setObject:[NSNumber numberWithDouble:284.6955] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.7475] forKey:@"DEC"];
        NSLog(@" jan 3: %f", angle);
    }
    //JAN 4
    else if(angle > 4.946517 && angle <= 4.965728){
        [dict setObject:[NSNumber numberWithDouble:285.7965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.6408] forKey:@"DEC"];
        NSLog(@" jan 4: %f", angle);
    }
    //JAN 5
    else if(angle > 4.965728 && angle <= 4.984909){
        [dict setObject:[NSNumber numberWithDouble:286.8915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.5269] forKey:@"DEC"];
        NSLog(@" jan 5: %f", angle);
    }
    //JAN 6
    else if(angle > 4.984909 && angle <= 5.004057){
        [dict setObject:[NSNumber numberWithDouble:286.788] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.4053] forKey:@"DEC"];
        NSLog(@" jan 6: %f", angle);
    }
    //JAN 7
    else if(angle > 5.004057 && angle <= 5.023172){
        [dict setObject:[NSNumber numberWithDouble:289.083] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.2761] forKey:@"DEC"];
        NSLog(@" jan 7: %f", angle);
    }
    //JAN 8
    else if(angle > 5.023172 && angle <= 5.042249){
        [dict setObject:[NSNumber numberWithDouble:290.1705] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-22.1403] forKey:@"DEC"];
        NSLog(@" jan 8: %f", angle);
    }
    //JAN 9
    else if(angle > 5.042249 && angle <= 5.061289){
        [dict setObject:[NSNumber numberWithDouble:291.2625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.9967] forKey:@"DEC"];
        NSLog(@" jan 9: %f", angle);
    }
    //JAN 10
    else if(angle > 5.061289 && angle <= 5.080288){
        [dict setObject:[NSNumber numberWithDouble:292.35] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.8461] forKey:@"DEC"];
        NSLog(@" jan 10: %f", angle);
    }
    //JAN 11
    else if(angle > 5.080288 && angle <= 5.099246){
        [dict setObject:[NSNumber numberWithDouble:293.4285] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.6889] forKey:@"DEC"];
        NSLog(@" jan 11: %f", angle);
    }
    //JAN 12
    else if(angle > 5.099246 && angle <= 5.118160){
        [dict setObject:[NSNumber numberWithDouble:294.513] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.5239] forKey:@"DEC"];
        NSLog(@" jan 12: %f", angle);
    }
    //JAN 13
    else if(angle > 5.118160 && angle <= 5.137030){
        [dict setObject:[NSNumber numberWithDouble:295.596] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.3522] forKey:@"DEC"];
        NSLog(@" jan 13: %f", angle);
    }
    //JAN 14
    else if(angle > 5.137030 && angle <= 5.155853){
        [dict setObject:[NSNumber numberWithDouble:296.667] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-21.1742] forKey:@"DEC"];
        NSLog(@" jan 14: %f", angle);
    }
    //JAN 15
    else if(angle > 5.155853 && angle <= 5.174629){
        [dict setObject:[NSNumber numberWithDouble:297.7455] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.9886] forKey:@"DEC"];
        NSLog(@" jan 15: %f", angle);
    }
    //JAN 16
    else if(angle > 5.174629 && angle <= 5.193357){
        [dict setObject:[NSNumber numberWithDouble:298.8165] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.7964] forKey:@"DEC"];
        NSLog(@" jan 16: %f", angle);
    }
    //JAN 17
    else if(angle > 5.193357 && angle <=  5.212035){
        [dict setObject:[NSNumber numberWithDouble:299.8785] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.5986] forKey:@"DEC"];
        NSLog(@" jan 17: %f", angle);
    }
    //JAN 18
    else if(angle >  5.212035 && angle <= 5.230663){
        [dict setObject:[NSNumber numberWithDouble:300.9465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.3933] forKey:@"DEC"];
        NSLog(@" jan 18 %f", angle);
    }
    //JAN 19
    else if(angle > 5.230663 && angle <= 5.249240){
        [dict setObject:[NSNumber numberWithDouble:302.0085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-20.1817] forKey:@"DEC"];
        NSLog(@" jan 19: %f", angle);
    }
    //JAN 20
    else if(angle > 5.249240 && angle <= 5.267764){
        [dict setObject:[NSNumber numberWithDouble:303.066] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.9644] forKey:@"DEC"];
        NSLog(@" jan 20: %f", angle);
    }
    //JAN 21
    else if(angle > 5.267764 && angle <= 5.286235){
        [dict setObject:[NSNumber numberWithDouble:304.1205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.7403] forKey:@"DEC"];
        NSLog(@" jan 21: %f", angle);
    }
    //JAN 22
    else if(angle > 5.286235 && angle <= 5.304652){
        [dict setObject:[NSNumber numberWithDouble:305.175] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.5097] forKey:@"DEC"];
        NSLog(@" jan 22: %f", angle);
    }
    //JAN 23
    else if(angle > 5.304652&& angle <= 5.323016){
        [dict setObject:[NSNumber numberWithDouble:306.2205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.2744] forKey:@"DEC"];
        NSLog(@" jan 23: %f", angle);
    }
    //JAN 24
    else if(angle > 5.323016 && angle <= 5.341324){
        [dict setObject:[NSNumber numberWithDouble:307.266] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-19.0322] forKey:@"DEC"];
        NSLog(@" jan 24: %f", angle);
    }
    //JAN 25
    else if(angle > 5.341324 && angle <= 5.359576){
        [dict setObject:[NSNumber numberWithDouble:308.313] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.7839] forKey:@"DEC"];
        NSLog(@" jan 25: %f", angle);
    }
    //JAN 26
    else if(angle > 5.359576 && angle <= 5.377773){
        [dict setObject:[NSNumber numberWithDouble:309.3465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.5311] forKey:@"DEC"];
        NSLog(@" jan 26: %f", angle);
    }
    //JAN 27
    else if(angle > 5.377773 && angle <= 5.395913){
        [dict setObject:[NSNumber numberWithDouble:310.383] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.2717] forKey:@"DEC"];
        NSLog(@" jan 27: %f", angle);
    }
    //JAN 28
    else if(angle > 5.395913 && angle <= 5.413995){
        [dict setObject:[NSNumber numberWithDouble:311.4165] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-18.0067] forKey:@"DEC"];
        NSLog(@" jan 28: %f", angle);
    }
    //JAN 29
    else if(angle > 5.413995 && angle <= 5.432021){
        [dict setObject:[NSNumber numberWithDouble:312.441] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.7375] forKey:@"DEC"];
        NSLog(@" jan 29: %f", angle);
    }
    //JAN 30
    else if(angle > 5.432021 && angle <= 5.449987){
        [dict setObject:[NSNumber numberWithDouble:313.4715] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.4619] forKey:@"DEC"];
        NSLog(@" jan 30: %f", angle);
    }
    //JAN 31
    else if(angle > 5.449987 && angle <= 5.467895){
        [dict setObject:[NSNumber numberWithDouble:314.4915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-17.1811] forKey:@"DEC"];
        NSLog(@" jan 31: %f", angle);
    }
    
    
    
/////////////////////////////////////////////  FEB  ///////////////////////////////////////////
    
    //FEB 1
    else if(angle > 5.467895 && angle <= 5.485744){
        [dict setObject:[NSNumber numberWithDouble:315.5085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.8964] forKey:@"DEC"];
        NSLog(@" feb 1: %f", angle);
    }
    //FEB 2
    else if(angle > 5.485744 && angle <= 5.503533){
        [dict setObject:[NSNumber numberWithDouble:316.5255] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.6056] forKey:@"DEC"];
        NSLog(@" feb 2: %f", angle);
    }

    //FEB 3
    else if(angle > 5.503533 && angle <= 5.521261){
        [dict setObject:[NSNumber numberWithDouble:317.538] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.31] forKey:@"DEC"];
        NSLog(@" feb 3: %f", angle);
    }
    //FEB 4
    else if(angle > 5.521261 && angle <= 5.538930){
        [dict setObject:[NSNumber numberWithDouble:318.546] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-16.0108] forKey:@"DEC"];
        NSLog(@" feb 4: %f", angle);
    }
    //FEB 5
    else if(angle > 5.538930 && angle <= 5.556538){
        [dict setObject:[NSNumber numberWithDouble:319.5495] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-15.7058] forKey:@"DEC"];
        NSLog(@" feb 5: %f", angle);
    }
    //FEB 6
    else if(angle > 5.556538 && angle <= 5.574086){
        [dict setObject:[NSNumber numberWithDouble:320.5545] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-15.3964] forKey:@"DEC"];
        NSLog(@" feb 6: %f", angle);
    }
    //FEB 7
    else if(angle > 5.574086 && angle <= 5.591574){
        [dict setObject:[NSNumber numberWithDouble:321.5505] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-15.0839] forKey:@"DEC"];
        NSLog(@" feb 7: %f", angle);
    }
    //FEB 8
    else if(angle > 5.591574 && angle <= 5.609003){
        [dict setObject:[NSNumber numberWithDouble:322.5465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.7658] forKey:@"DEC"];
        NSLog(@" feb 8: %f", angle);
    }
    //FEB 9
    else if(angle > 5.609003 && angle <= 5.626372){
        [dict setObject:[NSNumber numberWithDouble:323.541] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.4436] forKey:@"DEC"];
        NSLog(@" feb 9: %f", angle);
    }
    //FEB 10
    else if(angle > 5.626372 && angle <= 5.643684){
        [dict setObject:[NSNumber numberWithDouble:324.5295] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-14.1189] forKey:@"DEC"];
        NSLog(@" feb 10: %f", angle);
    }
    //FEB 11
    else if(angle > 5.643684 && angle <= 5.660938){
        [dict setObject:[NSNumber numberWithDouble:325.512] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-13.7886] forKey:@"DEC"];
        NSLog(@" feb 11: %f", angle);
    }
    //FEB 12
    else if(angle > 5.660938 && angle <= 5.678135){
        [dict setObject:[NSNumber numberWithDouble:325.5005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-13.4547] forKey:@"DEC"];
        NSLog(@" feb 12: %f", angle);
    }
    //FEB 13
    else if(angle > 5.678135 && angle <= 5.695277){
        [dict setObject:[NSNumber numberWithDouble:327.4755] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-13.1186] forKey:@"DEC"];
        NSLog(@" feb 13: %f", angle);
    }
    //FEB 14
    else if(angle > 5.695277 && angle <= 5.712363){
        [dict setObject:[NSNumber numberWithDouble:328.4535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-12.7772] forKey:@"DEC"];
        NSLog(@" feb 14: %f", angle);
    }
    //FEB 15
    else if(angle > 5.712363 && angle <= 5.729396){
        [dict setObject:[NSNumber numberWithDouble:329.4285] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.4328] forKey:@"DEC"];
        NSLog(@" feb 15: %f", angle);
    }
    //FEB 16
    else if(angle > 5.729396 && angle <= 5.746375){
        [dict setObject:[NSNumber numberWithDouble:330.396] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.0861] forKey:@"DEC"];
        NSLog(@" feb 16: %f", angle);
    }
 
    //FEB 17
    else if(angle > 5.746375 && angle <= 5.763303){
        [dict setObject:[NSNumber numberWithDouble:331.362] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-11.735] forKey:@"DEC"];
        NSLog(@" feb 17: %f", angle);
    }
    //FEB 18
    else if(angle > 5.763303 && angle <= 5.780180){
        [dict setObject:[NSNumber numberWithDouble:332.3295] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-11.3808] forKey:@"DEC"];
        NSLog(@" feb 18: %f", angle);
    }
    //FEB 19
    else if(angle > 5.780180 && angle <= 5.797009){
        [dict setObject:[NSNumber numberWithDouble:333.288] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-11.025] forKey:@"DEC"];
        NSLog(@" feb 19: %f", angle);
    }
    //FEB 20
    else if(angle > 5.797009 && angle <= 5.81379){
        [dict setObject:[NSNumber numberWithDouble:334.0005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-10.7614] forKey:@"DEC"];
        NSLog(@" feb 20: %f", angle);
    }
    //FEB 21
    else if(angle > 5.81379 && angle <= 5.830528){
        [dict setObject:[NSNumber numberWithDouble:335.2035] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-10.3019] forKey:@"DEC"];
        NSLog(@" feb 21: %f", angle);
    }
    //FEB 22
    else if(angle > 5.830528 && angle <= 5.847216){
        [dict setObject:[NSNumber numberWithDouble:336.1545] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-9.9381] forKey:@"DEC"];
        NSLog(@" feb 22: %f", angle);
    }
    //FEB 23
    else if(angle > 5.847216 && angle <= 5.863863){
        [dict setObject:[NSNumber numberWithDouble:337.1085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-9.57] forKey:@"DEC"];
        NSLog(@" feb 23: %f", angle);
    }
    //FEB 24
    else if(angle > 5.863863 && angle <= 5.880466){
        [dict setObject:[NSNumber numberWithDouble:338.3085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-9.1994] forKey:@"DEC"];
        NSLog(@" feb 24: %f", angle);
    }
    //FEB 25
    else if(angle > 5.880466 && angle <= 5.897027){
        [dict setObject:[NSNumber numberWithDouble:339.000] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-8.8283] forKey:@"DEC"];
        NSLog(@" feb 24: %f", angle);
    }
    //FEB 26
    else if(angle > 5.897027 && angle <= 5.913547){
        [dict setObject:[NSNumber numberWithDouble:339.9465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-8.4533] forKey:@"DEC"];
        NSLog(@" feb 26: %f", angle);
    }
    //FEB 27
    else if(angle > 5.880466 && angle <= 5.930026){
        [dict setObject:[NSNumber numberWithDouble:340.886] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-8.0764] forKey:@"DEC"];
        NSLog(@" feb 27: %f", angle);
    }
    //FEB 28
    else if(angle > 5.930026 && angle <=  5.946466){
        [dict setObject:[NSNumber numberWithDouble:341.8215] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-7.6989] forKey:@"DEC"];
        NSLog(@" feb 28: %f", angle);
    }
    
/////////////////////////////////   MAR   //////////////////////////////////////
    
    //MAR 1
    else if(angle >  5.913547 && angle <= 5.962837 ){
        [dict setObject:[NSNumber numberWithDouble:342.759] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-7.3181] forKey:@"DEC"];
        NSLog(@" mar 1: %f", angle);
    }
    //MAR 2
    else if(angle >  5.962837 && angle <=  5.847216){
        [dict setObject:[NSNumber numberWithDouble:343.6965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-6.9356] forKey:@"DEC"];
        NSLog(@" mar 2: %f", angle);
    }
    //MAR 3
    else if(angle > 5.847216  && angle <= 5.995522 ){
        [dict setObject:[NSNumber numberWithDouble:344.625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-6.5531] forKey:@"DEC"];
        NSLog(@" mar 3: %f", angle);
    }
    //MAR 4
    else if(angle > 5.995522  && angle <= 6.011811 ){
        [dict setObject:[NSNumber numberWithDouble:345.558] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-6.1672] forKey:@"DEC"];
        NSLog(@" mar 4: %f", angle);
    }
    //MAR 5
    else if(angle >  6.011811 && angle <= 6.028065 ){
        [dict setObject:[NSNumber numberWithDouble:346.488] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-5.78] forKey:@"DEC"];
        NSLog(@" mar 5: %f", angle);
    }
    //MAR 6
    else if(angle > 6.028065  && angle <= 6.044287 ){
        [dict setObject:[NSNumber numberWithDouble:347.412] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-5.3931] forKey:@"DEC"];
        NSLog(@" mar 6: %f", angle);
    }
    //MAR 7
    else if(angle > 6.044287  && angle <= 6.060477 ){
        [dict setObject:[NSNumber numberWithDouble:348.342] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-5.0033] forKey:@"DEC"];
        NSLog(@" mar 7: %f", angle);
    }
    //MAR 8
    else if(angle > 6.060477  && angle <= 6.076637 ){
        [dict setObject:[NSNumber numberWithDouble:349.266] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-4.6128] forKey:@"DEC"];
        NSLog(@" mar 8: %f", angle);
    }
    //MAR 9
    else if(angle >  6.076637 && angle <= 6.092767 ){
        [dict setObject:[NSNumber numberWithDouble:350.187] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-4.2225] forKey:@"DEC"];
        NSLog(@" mar 9: %f", angle);
    }
    //MAR 10
    else if(angle > 6.092767  && angle <= 6.108871 ){
        [dict setObject:[NSNumber numberWithDouble:351.108] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-3.83] forKey:@"DEC"];
        NSLog(@" mar 10: %f", angle);
    }
    //MAR 11
    else if(angle >  6.108871 && angle <= 6.124948 ){
        [dict setObject:[NSNumber numberWithDouble:352.0335] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-3.4364] forKey:@"DEC"];
        NSLog(@" mar 11: %f", angle);
    }
    //MAR 12
    else if(angle >  6.124948 && angle <= 6.141000 ){
        [dict setObject:[NSNumber numberWithDouble:352.95] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-3.0439] forKey:@"DEC"];
        NSLog(@" mar 12: %f", angle);
    }
    //MAR 13
    else if(angle > 6.141000  && angle <= 6.157030 ){
        [dict setObject:[NSNumber numberWithDouble:353.8665] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-2.6494] forKey:@"DEC"];
        NSLog(@" mar 13: %f", angle);
    }
    //MAR 14
    else if(angle >  6.157030 && angle <= 6.173038 ){
        [dict setObject:[NSNumber numberWithDouble:354.534] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-2.2542] forKey:@"DEC"];
        NSLog(@" mar 14: %f", angle);
    }
    //MAR 15
    else if(angle > 6.173038  && angle <= 6.189026 ){
        [dict setObject:[NSNumber numberWithDouble:355.6995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-1.8603] forKey:@"DEC"];
        NSLog(@" mar 15: %f", angle);
    }
    //MAR 16
    else if(angle > 6.189026  && angle <= 6.204997 ){
        [dict setObject:[NSNumber numberWithDouble:356.613] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-1.4644] forKey:@"DEC"];
        NSLog(@" mar 16: %f", angle);
    }
    //MAR 17
    else if(angle > 6.204997  && angle <= 6.220951 ){
        [dict setObject:[NSNumber numberWithDouble:357.5295] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-1.0686] forKey:@"DEC"];
        NSLog(@" mar 17: %f", angle);
    }
    //MAR 18
    else if(angle > 6.220951  && angle <= 6.236891 ){
        [dict setObject:[NSNumber numberWithDouble:358.4415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-.6744] forKey:@"DEC"];
        NSLog(@" mar 18: %f", angle);
    }
    //MAR 19
    else if(angle >  6.236891 && angle <= 6.252818 ){
        [dict setObject:[NSNumber numberWithDouble:359.3535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:-.2783] forKey:@"DEC"];
        NSLog(@" mar 19: %f", angle);
    }
    //MAR 20
    else if(angle >  6.252818 && angle <= 6.268735){
        [dict setObject:[NSNumber numberWithDouble:.267] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:.1172] forKey:@"DEC"];
        NSLog(@" mar 20: %f", angle);
    }
    //MAR 21
    else if(angle > 6.268735 && angle <= 0.001455 ){
        [dict setObject:[NSNumber numberWithDouble:1.1745] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:.5111] forKey:@"DEC"];
        NSLog(@" mar 21: %f", angle);
    }
    //MAR 22
    else if(angle > 0.001455  && angle <= 0.017355 ){
        [dict setObject:[NSNumber numberWithDouble:2.088] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:.9064] forKey:@"DEC"];
        NSLog(@" mar 22: %f", angle);
    }
    //MAR 23
    else if(angle > 0.017355  && angle <= 0.033248 ){
        [dict setObject:[NSNumber numberWithDouble:3.00] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:1.3011] forKey:@"DEC"];
        NSLog(@" mar 23: %f", angle);
    }
    //MAR 24
    else if(angle >  0.033248 && angle <= 0.049137 ){
        [dict setObject:[NSNumber numberWithDouble:3.9045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:1.6936] forKey:@"DEC"];
        NSLog(@" mar 24: %f", angle);
    }
    //MAR 25
    else if(angle > 0.049137 && angle <= 0.065024 ){
        [dict setObject:[NSNumber numberWithDouble:4.8165] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:2.0869] forKey:@"DEC"];
        NSLog(@" mar 25: %f", angle);
    }
    //MAR 26
    else if(angle > 0.065024  && angle <= 0.080909 ){
        [dict setObject:[NSNumber numberWithDouble:5.7285] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:2.4797] forKey:@"DEC"];
        NSLog(@" mar 26: %f", angle);
    }
    //MAR 27
    else if(angle > 0.080909  && angle <= 0.096794 ){
        [dict setObject:[NSNumber numberWithDouble:6.675] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:2.87] forKey:@"DEC"];
        NSLog(@" mar 27: %f", angle);
    }
    //MAR 28
    else if(angle > 0.096794  && angle <= 0.112681 ){
        [dict setObject:[NSNumber numberWithDouble:7.5465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:3.2608] forKey:@"DEC"];
        NSLog(@" mar 28: %f", angle);
    }
    //MAR 29
    else if(angle > 0.112681  && angle <= 0.128570 ){
        [dict setObject:[NSNumber numberWithDouble:8.4585] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:3.6508] forKey:@"DEC"];
        NSLog(@" mar 29: %f", angle);
    }
    //MAR 30
    else if(angle > 0.128570  && angle <= 0.144464 ){
        [dict setObject:[NSNumber numberWithDouble:9.363] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:4.0381] forKey:@"DEC"];
        NSLog(@" mar 30: %f", angle);
    }
    //MAR 31
    else if(angle >  0.144464 && angle <= 0.160362 ){
        [dict setObject:[NSNumber numberWithDouble:10.275] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:4.4256] forKey:@"DEC"];
        NSLog(@" mar 31: %f", angle);
    }
    
    
  /////////////////////////////////   APR    //////////////////////////////////////
    
    
    //APR 1
    else if(angle >  0.160362 && angle <= 0.176265 ){
        [dict setObject:[NSNumber numberWithDouble:11.187] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:4.8117] forKey:@"DEC"];
        NSLog(@" apr 1: %f", angle);
    }
    //APR 2
    else if(angle > 0.176265  && angle <= 0.192176 ){
        [dict setObject:[NSNumber numberWithDouble:12.1005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:5.1947] forKey:@"DEC"];
        NSLog(@" apr 2: %f", angle);
    }
    //APR 3
    else if(angle >  0.192176 && angle <= 0.208095){
        [dict setObject:[NSNumber numberWithDouble:13.0125] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:5.5781] forKey:@"DEC"];
        NSLog(@" apr 3: %f", angle);
    }
    //APR 4
    else if(angle > 0.208095 && angle <= 0.224024 ){
        [dict setObject:[NSNumber numberWithDouble:13.9245] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:5.9094] forKey:@"DEC"];
        NSLog(@" apr 4: %f", angle);
    }
    //APR 5
    else if(angle > 0.224024  && angle <=  0.239963){
        [dict setObject:[NSNumber numberWithDouble:14.838] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:6.3378] forKey:@"DEC"];
        NSLog(@" apr 5: %f", angle);
    }
    //APR 6
    else if(angle >  0.239963 && angle <= 0.255913 ){
        [dict setObject:[NSNumber numberWithDouble:15.7545] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:6.7158] forKey:@"DEC"];
        NSLog(@" apr 6: %f", angle);
    }
    //APR 7
    else if(angle >  0.255913 && angle <= 0.271877 ){
        [dict setObject:[NSNumber numberWithDouble:16.671] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:7.0919] forKey:@"DEC"];
        NSLog(@" apr 7: %f", angle);
    }
    //APR 8
    else if(angle >  0.271877 && angle <= 0.287855 ){
        [dict setObject:[NSNumber numberWithDouble:17.5875] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:7.4644] forKey:@"DEC"];
        NSLog(@" apr 8: %f", angle);
    }
  
    //APR 9
    else if(angle > 0.287855   && angle <= 0.307937 ){
        [dict setObject:[NSNumber numberWithDouble:18.504] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:7.8364] forKey:@"DEC"];
        NSLog(@" apr 9: %f", angle);
    }
    //APR 10
    else if(angle > 0.307937  && angle <= 0.319905 ){
        [dict setObject:[NSNumber numberWithDouble:19.425] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:8.2064] forKey:@"DEC"];
        NSLog(@" apr 10: %f", angle);
    }
    //APR 11
    else if(angle > 0.319905  && angle <=  0.335930){
        [dict setObject:[NSNumber numberWithDouble:20.3415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:8.5722] forKey:@"DEC"];
        NSLog(@" apr 11: %f", angle);
    }
    //APR 12
    else if(angle >  0.335930 && angle <= 0.351974 ){
        [dict setObject:[NSNumber numberWithDouble:21.267] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:8.9372] forKey:@"DEC"];
        NSLog(@" apr 12: %f", angle);
    }
    //APR 13
    else if(angle > 0.351974  && angle <= 0.368039 ){
        [dict setObject:[NSNumber numberWithDouble:22.1085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:9.300] forKey:@"DEC"];
        NSLog(@" apr 13: %f", angle);
    }
    //APR 14
    else if(angle > 0.368039  && angle <= 0.384127 ){
        [dict setObject:[NSNumber numberWithDouble:23.112] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:9.6583] forKey:@"DEC"];
        NSLog(@" apr 14: %f", angle);
    }
    //APR 15
    else if(angle > 0.384127  && angle <= 0.400237 ){
        [dict setObject:[NSNumber numberWithDouble:24.0375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:10.0158] forKey:@"DEC"];
        NSLog(@" apr 15: %f", angle);
    }
    //APR 16
    else if(angle > 0.400237  && angle <=  0.416373){
        [dict setObject:[NSNumber numberWithDouble:24.966] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:10.3706] forKey:@"DEC"];
        NSLog(@" apr 16: %f", angle);
    }
    //APR 17
    else if(angle > 0.416373  && angle <= 0.432535 ){
        [dict setObject:[NSNumber numberWithDouble:25.8915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:10.7206] forKey:@"DEC"];
        NSLog(@" apr 17: %f", angle);
    }
    //APR 18
    else if(angle >  0.432535 && angle <=  0.448725 ){
        [dict setObject:[NSNumber numberWithDouble:26.8245] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:11.0694] forKey:@"DEC"];
        NSLog(@" apr 18: %f", angle);
    }
    //APR 19
    else if(angle >  0.448725  && angle <=  0.464944){
        [dict setObject:[NSNumber numberWithDouble:27.759] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:11.4153] forKey:@"DEC"];
        NSLog(@" apr 19: %f", angle);
    }
    //APR 20
    else if(angle >  0.464944 && angle <= 0.481194 ){
        [dict setObject:[NSNumber numberWithDouble:28.6875] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:11.7564] forKey:@"DEC"];
        NSLog(@" apr 20: %f", angle);
    }
    //APR 21
    else if(angle > 0.481194  && angle <= 0.497475 ){
        [dict setObject:[NSNumber numberWithDouble:29.625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.0958] forKey:@"DEC"];
        NSLog(@" apr 21: %f", angle);
    }
    //APR 22
    else if(angle > 0.497475  && angle <=   0.517992){
        [dict setObject:[NSNumber numberWithDouble:30.5625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.4319] forKey:@"DEC"];
        NSLog(@" apr 22: %f", angle);
    }
    //APR 23
    else if(angle > 0.517992 && angle <=  0.534342){
        [dict setObject:[NSNumber numberWithDouble:31.4955] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.7631] forKey:@"DEC"];
        NSLog(@" apr 23: %f", angle);
    }
    //APR 24
    else if(angle >  0.534342 && angle <= 0.546518 ){
        [dict setObject:[NSNumber numberWithDouble:32.4375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:13.0922] forKey:@"DEC"];
        NSLog(@" apr 24: %f", angle);
    }
    //APR 25
    else if(angle >  0.546518 && angle <= 0.562936 ){
        [dict setObject:[NSNumber numberWithDouble:33.384] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:13.4178] forKey:@"DEC"];
        NSLog(@" apr 25: %f", angle);
    }
    //APR 26
    else if(angle > 0.562936  && angle <= 0.579389 ){
        [dict setObject:[NSNumber numberWithDouble:34.3245] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:13.7381] forKey:@"DEC"];
        NSLog(@" apr 26: %f", angle);
    }
    //APR 27
    else if(angle > 0.579389  && angle <= 0.595879 ){
        [dict setObject:[NSNumber numberWithDouble:35.2755] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.0564] forKey:@"DEC"];
        NSLog(@" apr 27: %f", angle);
    }
    //APR 28
    else if(angle > 0.595879  && angle <= 0.612406 ){
        [dict setObject:[NSNumber numberWithDouble:36.225] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.3706] forKey:@"DEC"];
        NSLog(@" apr 28: %f", angle);
    }
    //APR 29
    else if(angle > 0.612406  && angle <= 0.628970 ){
        [dict setObject:[NSNumber numberWithDouble:37.1715] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.6794] forKey:@"DEC"];
        NSLog(@" apr 29: %f", angle);
    }
    //APR 30
    else if(angle > 0.628970  && angle <= 0.649758 ){
        [dict setObject:[NSNumber numberWithDouble:38.1255] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.9856] forKey:@"DEC"];
        NSLog(@" apr 30: %f", angle);
    }
 
///////////////////////////////  MAY   ////////////////////////////////
  
    //MAY 1
    else if(angle > 0.649758  && angle <= 0.666397 ){
        [dict setObject:[NSNumber numberWithDouble:39.084] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.2878] forKey:@"DEC"];
        NSLog(@" may 1: %f", angle);
    }
    //MAY 2
    else if(angle > 0.666397  && angle <= 0.683076 ){
        [dict setObject:[NSNumber numberWithDouble:40.038] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.5842] forKey:@"DEC"];
        NSLog(@" may 2: %f", angle);
    }
    //MAY 3
    else if(angle >  0.683076 && angle <= 0.699797 ){
        [dict setObject:[NSNumber numberWithDouble:40.9995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.8778] forKey:@"DEC"];
        NSLog(@" may 3: %f", angle);
    }
    //MAY 4
    else if(angle >  0.699797 && angle <= 0.712363 ){
        [dict setObject:[NSNumber numberWithDouble:41.967] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:16.1669] forKey:@"DEC"];
        NSLog(@" may 4: %f", angle);
    }
    //MAY 5
    else if(angle > 0.712363  && angle <= 0.733362 ){
        [dict setObject:[NSNumber numberWithDouble:42.9285] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:16.4506] forKey:@"DEC"];
        NSLog(@" may 5: %f", angle);
    }
    //MAY 6
    else if(angle >  0.733362 && angle <= 0.750207 ){
        [dict setObject:[NSNumber numberWithDouble:43.896] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:16.7306] forKey:@"DEC"];
        NSLog(@" may 6: %f", angle);
    }
    //MAY 7
    else if(angle > 0.750207  && angle <= 0.762993 ){
        [dict setObject:[NSNumber numberWithDouble:44.8665] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.0069] forKey:@"DEC"];
        NSLog(@" may 7: %f", angle);
    }
    //MAY 8
    else if(angle > 0.762993  && angle <= 0.779916 ){
        [dict setObject:[NSNumber numberWithDouble:45.837] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.2756] forKey:@"DEC"];
        NSLog(@" may 8: %f", angle);
    }
    //MAY 9
    else if(angle >  0.779916 && angle <= 0.813883 ){
        [dict setObject:[NSNumber numberWithDouble:46.812] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.5414] forKey:@"DEC"];
        NSLog(@" may 9: %f", angle);
    }
    //MAY 10
    else if(angle > 0.813883  && angle <= 0.813883 ){
        [dict setObject:[NSNumber numberWithDouble:47.7915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.8025] forKey:@"DEC"];
        NSLog(@" may 10: %f", angle);
    }
    //MAY 11
    else if(angle > 0.813883  && angle <= 0.830927 ){
        [dict setObject:[NSNumber numberWithDouble:48.771] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.0572] forKey:@"DEC"];
        NSLog(@" may 11: %f", angle);
    }
    //MAY 12
    else if(angle > 0.830927  && angle <= 0.848012 ){
        [dict setObject:[NSNumber numberWithDouble:49.7535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.3083] forKey:@"DEC"];
        NSLog(@" may 12: %f", angle);
    }
    //MAY 13
    else if(angle > 0.848012  && angle <= 0.865138 ){
        [dict setObject:[NSNumber numberWithDouble:50.7375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.5542] forKey:@"DEC"];
        NSLog(@" may 13: %f", angle);
    }
    //MAY 14
    else if(angle >  0.865138 && angle <= 0.882306 ){
        [dict setObject:[NSNumber numberWithDouble:51.7215] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.7936] forKey:@"DEC"];
        NSLog(@" may 14: %f", angle);
    }
    //MAY 15
    else if(angle >  0.882306 && angle <= 0.899515){
        [dict setObject:[NSNumber numberWithDouble:3.5142] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.0289] forKey:@"DEC"];
        NSLog(@" may 15: %f", angle);
    }
    //MAY 16
    else if(angle > 0.899515  && angle <= 0.916765 ){
        [dict setObject:[NSNumber numberWithDouble:53.7045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.2589] forKey:@"DEC"];
        NSLog(@" may 16: %f", angle);
    }
    //MAY 17
    else if(angle >  0.916765 && angle <= 0.934057 ){
        [dict setObject:[NSNumber numberWithDouble:54.694] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.4822] forKey:@"DEC"];
        NSLog(@" may 17: %f", angle);
    }
    //MAY 18
    else if(angle >  0.934057 && angle <= 0.951391 ){
        [dict setObject:[NSNumber numberWithDouble:51.192] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.7011] forKey:@"DEC"];
        NSLog(@" may 18: %f", angle);
    }
    //MAY 19
    else if(angle > 0.951391  && angle <= 0.968766 ){
        [dict setObject:[NSNumber numberWithDouble:56.691] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.9144] forKey:@"DEC"];
        NSLog(@" may 19: %f", angle);
    }
    //MAY 20
    else if(angle >  0.968766 && angle <= 0.986183 ){
        [dict setObject:[NSNumber numberWithDouble:57.687] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.1214] forKey:@"DEC"];
        NSLog(@" may 20: %f", angle);
    }
    //MAY 21
    else if(angle > 0.986183 && angle <= 1.003641 ){
        [dict setObject:[NSNumber numberWithDouble:58.692] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.3233] forKey:@"DEC"];
        NSLog(@" may 21: %f", angle);
    }
    //MAY 22
    else if(angle > 1.003641  && angle <=  1.021141){
        [dict setObject:[NSNumber numberWithDouble:59.7] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.5194] forKey:@"DEC"];
        NSLog(@" may 22: %f", angle);
    }
    //MAY 23
    else if(angle >  1.021141 && angle <= 1.038680 ){
        [dict setObject:[NSNumber numberWithDouble:60.708] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.7094] forKey:@"DEC"];
        NSLog(@" may 23: %f", angle);
    }
    //MAY 24
    else if(angle >  1.038680  && angle <= 1.056259 ){
        [dict setObject:[NSNumber numberWithDouble:61.713] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.8931] forKey:@"DEC"];
        NSLog(@" may 24: %f", angle);
    }
    //MAY 25
    else if(angle > 1.056259  && angle <= 1.073876 ){
        [dict setObject:[NSNumber numberWithDouble:62.7255] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.0714] forKey:@"DEC"];
        NSLog(@" may 25: %f", angle);
    }
    //MAY 26
    else if(angle > 1.073876  && angle <= 1.091531 ){
        [dict setObject:[NSNumber numberWithDouble:63.288] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.2436] forKey:@"DEC"];
        NSLog(@" may 26: %f", angle);
    }
    //MAY 27
    else if(angle >  1.091531 && angle <=  1.109223){
        [dict setObject:[NSNumber numberWithDouble:64.7505] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.4089] forKey:@"DEC"];
        NSLog(@" may 27: %f", angle);
    }
    //MAY 28
    else if(angle > 1.109223  && angle <= 1.126949 ){
        [dict setObject:[NSNumber numberWithDouble:65.766] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.5689] forKey:@"DEC"];
        NSLog(@" may 28: %f", angle);
    }
    //MAY 29
    else if(angle > 1.126949  && angle <= 1.144710 ){
        [dict setObject:[NSNumber numberWithDouble:66.7875] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.7225] forKey:@"DEC"];
        NSLog(@" may 29: %f", angle);
    }
    //MAY 30
    else if(angle >  1.144710 && angle <= 1.162504 ){
        [dict setObject:[NSNumber numberWithDouble:67.8045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.8692] forKey:@"DEC"];
        NSLog(@" may 30: %f", angle);
    }
    //MAY 31
    else if(angle > 1.162504  && angle <= 1.180329 ){
        [dict setObject:[NSNumber numberWithDouble:68.829] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.01] forKey:@"DEC"];
        NSLog(@" may 31: %f", angle);
    }
    

/////////////////////////////////   JUN    //////////////////////////////////////

    //JUN 1
    else if(angle > 1.180329  && angle <= 1.198189 ){
        [dict setObject:[NSNumber numberWithDouble:69.9] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.1447] forKey:@"DEC"];
        NSLog(@" jun 1: %f", angle);
    }
    //JUN 2
    else if(angle >  1.198189 && angle <= 1.216074 ){
        [dict setObject:[NSNumber numberWithDouble:70.897] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.2722] forKey:@"DEC"];
        NSLog(@" jun 2: %f", angle);
    }
    //JUN 3
    else if(angle >  1.216074 && angle <=  1.233985){
        [dict setObject:[NSNumber numberWithDouble:71.9085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.3939] forKey:@"DEC"];
        NSLog(@" jun 3: %f", angle);
    }
    //JUN 4
    else if(angle > 1.233985  && angle <= 1.251923 ){
        [dict setObject:[NSNumber numberWithDouble:72.9375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.5092] forKey:@"DEC"];
        NSLog(@" jun 4: %f", angle);
    }
    //JUN 5
    else if(angle > 1.251923  && angle <= 1.269885 ){
        [dict setObject:[NSNumber numberWithDouble:73.9665] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.6172] forKey:@"DEC"];
        NSLog(@" jun 5: %f", angle);
    }
    //JUN 6
    else if(angle >  1.269885 && angle <= 1.287870 ){
        [dict setObject:[NSNumber numberWithDouble:74.9955] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.7192] forKey:@"DEC"];
        NSLog(@" jun 6: %f", angle);
    }
    //JUN 7
    else if(angle >  1.287870 && angle <= 1.305876 ){
        [dict setObject:[NSNumber numberWithDouble:76.0335] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.8144] forKey:@"DEC"];
        NSLog(@" jun 7: %f", angle);
    }
    //JUN 8
    else if(angle > 1.305876  && angle <= 1.323904 ){
        [dict setObject:[NSNumber numberWithDouble:77.0625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.9025] forKey:@"DEC"];
        NSLog(@" jun 8: %f", angle);
    }
    //JUN 9
    else if(angle >  1.323904 && angle <= 1.341949 ){
        [dict setObject:[NSNumber numberWithDouble:78.1005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.9844] forKey:@"DEC"];
        NSLog(@" jun 9: %f", angle);
    }
    //JUN 10
    else if(angle > 1.341949  && angle <= 1.360013 ){
        [dict setObject:[NSNumber numberWithDouble:79.137] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.0594] forKey:@"DEC"];
        NSLog(@" jun 10: %f", angle);
    }
    //JUN 11
    else if(angle > 1.360013  && angle <= 1.378092 ){
        [dict setObject:[NSNumber numberWithDouble:80.1705] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.1275] forKey:@"DEC"];
        NSLog(@" jun 11: %f", angle);
    }
    //JUN 12
    else if(angle >  1.378092 && angle <= 1.396186 ){
        [dict setObject:[NSNumber numberWithDouble:81.2085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.1892] forKey:@"DEC"];
        NSLog(@" jun 12: %f", angle);
    }
    //JUN 13
    else if(angle > 1.396186  && angle <= 1.414294 ){
        [dict setObject:[NSNumber numberWithDouble:82.2495] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.2439] forKey:@"DEC"];
        NSLog(@" jun 13: %f", angle);
    }
    //JUN 14
    else if(angle > 1.414294  && angle <= 1.432414 ){
        [dict setObject:[NSNumber numberWithDouble:83.2875] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.2917] forKey:@"DEC"];
        NSLog(@" jun 14: %f", angle);
    }
    //JUN 15
    else if(angle > 1.432414  && angle <=  1.450545){
        [dict setObject:[NSNumber numberWithDouble:84.3255] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.1957] forKey:@"DEC"];
        NSLog(@" jun 15: %f", angle);
    }
    //JUN 16
    else if(angle >  1.450545 && angle <= 1.468686 ){
        [dict setObject:[NSNumber numberWithDouble:85.3665] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.3667] forKey:@"DEC"];
        NSLog(@" jun 16: %f", angle);
    }
    //JUN 17
    else if(angle >  1.468686 && angle <= 1.486835 ){
        [dict setObject:[NSNumber numberWithDouble:86.4045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.3939] forKey:@"DEC"];
        NSLog(@" jun 17: %f", angle);
    }
    //JUN 18
    else if(angle > 1.486835  && angle <= 1.504991 ){
        [dict setObject:[NSNumber numberWithDouble:87.4455] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.4142] forKey:@"DEC"];
        NSLog(@" jun 18: %f", angle);
    }
    //JUN 19
    else if(angle >  1.504991 && angle <= 1.523153 ){
        [dict setObject:[NSNumber numberWithDouble:88.488] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.4278] forKey:@"DEC"];
        NSLog(@" jun 19: %f", angle);
    }
    //JUN 20
    else if(angle > 1.523153  && angle <= 1.541318 ){
        [dict setObject:[NSNumber numberWithDouble:89.5245] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.4342] forKey:@"DEC"];
        NSLog(@" jun 20: %f", angle);
    }
    //JUN 21
    else if(angle >  1.541318 && angle <= 1.559486 ){
        [dict setObject:[NSNumber numberWithDouble:90.567] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.4339] forKey:@"DEC"];
        NSLog(@" jun 21: %f", angle);
    }
    //JUN 22
    else if(angle >  1.559486 && angle <= 1.577654 ){
        [dict setObject:[NSNumber numberWithDouble:91.6035] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.4267] forKey:@"DEC"];
        NSLog(@" jun 22: %f", angle);
    }
    //JUN 23
    else if(angle > 1.577654  && angle <= 1.595820 ){
        [dict setObject:[NSNumber numberWithDouble:92.6415] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.4125] forKey:@"DEC"];
        NSLog(@" jun 23: %f", angle);
    }
    //JUN 24
    else if(angle > 1.595820  && angle <= 1.613982 ){
        [dict setObject:[NSNumber numberWithDouble:93.684] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.3917] forKey:@"DEC"];
        NSLog(@" jun 24: %f", angle);
    }
    //JUN 25
    else if(angle >  1.613982 && angle <= 1.632139 ){
        [dict setObject:[NSNumber numberWithDouble:94.7205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.3636] forKey:@"DEC"];
        NSLog(@" jun 25: %f", angle);
    }
    //JUN 26
    else if(angle > 1.632139  && angle <= 1.650288 ){
        [dict setObject:[NSNumber numberWithDouble:95.7585] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.3292] forKey:@"DEC"];
        NSLog(@" jun 26: %f", angle);
    }
    //JUN 27
    else if(angle > 1.650288  && angle <= 1.668428 ){
        [dict setObject:[NSNumber numberWithDouble:96.7965] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.2875] forKey:@"DEC"];
        NSLog(@" jun 27: %f", angle);
    }
    //JUN 28
    else if(angle > 1.668428  && angle <= 1.686556 ){
        [dict setObject:[NSNumber numberWithDouble:97.833] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.2392] forKey:@"DEC"];
        NSLog(@" jun 28: %f", angle);
    }
    //JUN 29
    else if(angle > 1.686556  && angle <= 1.704671 ){
        [dict setObject:[NSNumber numberWithDouble:98.8665] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.1842] forKey:@"DEC"];
        NSLog(@" jun 29: %f", angle);
    }
    //JUN 30
    else if(angle > 1.704671 && angle <= 1.722770 ){
        [dict setObject:[NSNumber numberWithDouble:99.9045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.1222] forKey:@"DEC"];
        NSLog(@" jun 30: %f", angle);
    }
   
   
 /////////////////////////////////   JUL    //////////////////////////////////////
    
    
    
    //JUL 1
    else if(angle > 1.722770  && angle <= 1.740852 ){
        [dict setObject:[NSNumber numberWithDouble:100.938] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:23.0536] forKey:@"DEC"];
        NSLog(@" jul 1: %f", angle);
    }
    //JUL 2
    else if(angle > 1.740852 && angle <= 1.758915 ){
        [dict setObject:[NSNumber numberWithDouble:101.967] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.9783] forKey:@"DEC"];
        NSLog(@" jul 2: %f", angle);
    }
    //JUL 3
    else if(angle >  1.758915 && angle <= 1.776958 ){
        [dict setObject:[NSNumber numberWithDouble:103.0005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.8964] forKey:@"DEC"];
        NSLog(@" jul 3: %f", angle);
    }
    //JUL 4
    else if(angle > 1.776958 && angle <= 1.794977 ){
        [dict setObject:[NSNumber numberWithDouble:104.034] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.8075] forKey:@"DEC"];
        NSLog(@" jul 4: %f", angle);
    }
    //JUL 5
    else if(angle > 1.794977 && angle <= 1.812967 ){
        [dict setObject:[NSNumber numberWithDouble:105.0585] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.7125] forKey:@"DEC"];
        NSLog(@" jul 5: %f", angle);
    }
    //JUL 6
    else if(angle >  1.812967 && angle <= 1.830937 ){
        [dict setObject:[NSNumber numberWithDouble:106.0875] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.6106] forKey:@"DEC"];
        NSLog(@" jul 6: %f", angle);
    }
    //JUL 7
    else if(angle > 1.830937 && angle <= 1.848880){
        [dict setObject:[NSNumber numberWithDouble:107.1165] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.5019] forKey:@"DEC"];
        NSLog(@" jul 7: %f", angle);
    }
    //JUL 8
    else if(angle > 1.848880 && angle <= 1.866794 ){
        [dict setObject:[NSNumber numberWithDouble:108.0435] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.3875] forKey:@"DEC"];
        NSLog(@" jul 8: %f", angle);
    }
    //JUL 9
    else if(angle > 1.866794  && angle <= 1.884679){
        [dict setObject:[NSNumber numberWithDouble:109.1625] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.2661] forKey:@"DEC"];
        NSLog(@" jul 9: %f", angle);
    }

    
    //JUL 10
    else if(angle > 1.884679 && angle <= 1.906116 ){
        [dict setObject:[NSNumber numberWithDouble:110.184] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.1383] forKey:@"DEC"];
        NSLog(@" jul 10: %f", angle);
    }
    //JUL 11
    else if(angle > 1.906116 && angle <=  1.923934){
        [dict setObject:[NSNumber numberWithDouble:111.1995] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:22.0047] forKey:@"DEC"];
        NSLog(@" jul 11: %f", angle);
    }
    //JUL 12
    else if(angle > 1.923934  && angle <= 1.941720 ){
        [dict setObject:[NSNumber numberWithDouble:112.2165] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.8642] forKey:@"DEC"];
        NSLog(@" jul 12: %f", angle);
    }
    //JUL 13
    else if(angle > 1.941720 && angle <= 1.954979){
        [dict setObject:[NSNumber numberWithDouble:113.2335] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.7175] forKey:@"DEC"];
        NSLog(@" jul 13: %f", angle);
    }
    //JUL 14
    else if(angle > 1.954979 && angle <=  1.977186 ){
        [dict setObject:[NSNumber numberWithDouble:114.246] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.565] forKey:@"DEC"];
        NSLog(@" jul 14: %f", angle);
    }
    //JUL 15
    else if(angle >   1.977186 && angle <=  1.994865 ){
        [dict setObject:[NSNumber numberWithDouble:115.2585] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.4061] forKey:@"DEC"];
        NSLog(@" jul 15: %f", angle);
    }
    //JUL 16
    else if(angle >  1.994865 && angle <= 2.012506){
        [dict setObject:[NSNumber numberWithDouble:116.2665] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.2408] forKey:@"DEC"];
        NSLog(@" jul 16: %f", angle);
    }
    //JUL 17
    else if(angle >2.012506 && angle <= 2.030109 ){
        [dict setObject:[NSNumber numberWithDouble:117.2715] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:21.0706] forKey:@"DEC"];
        NSLog(@" jul 17: %f", angle);
    }
    //JUL 18
    else if(angle > 2.030109  && angle <= 2.047672 ){
        [dict setObject:[NSNumber numberWithDouble:118.275] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.8933] forKey:@"DEC"];
        NSLog(@" jul 18: %f", angle);
    }
    //JUL 19
    else if(angle > 2.047672 && angle <= 2.065194){
        [dict setObject:[NSNumber numberWithDouble:119.2785] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.7106] forKey:@"DEC"];
        NSLog(@" jul 19: %f", angle);
    }
    //JUL 20
    else if(angle > 2.065194 && angle <= 2.082675 ){
        [dict setObject:[NSNumber numberWithDouble:120.2745] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.5225] forKey:@"DEC"];
        NSLog(@" jul 20: %f", angle);
    }
    //JUL 21
    else if(angle > 2.082675  && angle <=  2.100115){
        [dict setObject:[NSNumber numberWithDouble:121.275] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.3281] forKey:@"DEC"];
        NSLog(@" jul 21: %f", angle);
    }
    //JUL 22
    else if(angle > 2.100115 && angle <= 2.117513){
        [dict setObject:[NSNumber numberWithDouble:122.271] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:20.1278] forKey:@"DEC"];
        NSLog(@" jul 22: %f", angle);
    }
    //JUL 23
    else if(angle > 2.117513 && angle <= 2.134870 ){
        [dict setObject:[NSNumber numberWithDouble:123.258] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.9228] forKey:@"DEC"];
        NSLog(@" jul 23: %f", angle);
    }
    //JUL 24
    else if(angle > 2.134870  && angle <= 2.152184 ){
        [dict setObject:[NSNumber numberWithDouble:124.2495] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.7114] forKey:@"DEC"];
        NSLog(@" jul 24: %f", angle);
    }
    //JUL 25
    else if(angle > 2.152184 && angle <= 2.169456){
        [dict setObject:[NSNumber numberWithDouble:125.241] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.4944] forKey:@"DEC"];
        NSLog(@" jul 25: %f", angle);
    }
    //JUL 26
    else if(angle > 2.169456 && angle <=  2.186686){
        [dict setObject:[NSNumber numberWithDouble:126.2205] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.2733] forKey:@"DEC"];
        NSLog(@" jul 26: %f", angle);
    }
    //JUL 27
    else if(angle > 2.186686  && angle <= 2.203873 ){
        [dict setObject:[NSNumber numberWithDouble:127.2045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:19.0458] forKey:@"DEC"];
        NSLog(@" jul 27: %f", angle);
    }
    //JUL 28
    else if(angle > 2.203873 && angle <= 2.221019){
        [dict setObject:[NSNumber numberWithDouble:128.187] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.8131] forKey:@"DEC"];
        NSLog(@" jul 28: %f", angle);
    }
    //JUL 29
    else if(angle > 2.221019 && angle <= 2.238122 ){
        [dict setObject:[NSNumber numberWithDouble:129.162] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.5761] forKey:@"DEC"];
        NSLog(@" jul 29: %f", angle);
    }
    //JUL 30
    else if(angle > 2.238122  && angle <= 2.255182 ){
        [dict setObject:[NSNumber numberWithDouble:130.137] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.3331] forKey:@"DEC"];
        NSLog(@" jul 30: %f", angle);
    }
    //JUL 31
    else if(angle > 2.255182 && angle <= 2.272199){
        [dict setObject:[NSNumber numberWithDouble:131.112] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:18.085] forKey:@"DEC"];
        NSLog(@" jul 31: %f", angle);
    }



    /////////////////////////////////   AUG    //////////////////////////////////////
    
    
    
    //AUG 1
    else if(angle >  2.272199 && angle <= 2.289174 ){
        [dict setObject:[NSNumber numberWithDouble:132.0795] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.8331] forKey:@"DEC"];
        NSLog(@" aug 1: %f", angle);
    }
    //AUG 2
    else if(angle > 2.289174 && angle <=  2.306105 ){
        [dict setObject:[NSNumber numberWithDouble:133.05] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.5753] forKey:@"DEC"];
        NSLog(@" aug 2: %f", angle);
    }
    //AUG 3
    else if(angle >  2.306105  && angle <= 2.322993 ){
        [dict setObject:[NSNumber numberWithDouble:134.016] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.3128] forKey:@"DEC"];
        NSLog(@" aug 3: %f", angle);
    }
    //AUG 4
    else if(angle > 2.322993 && angle <= 2.339838 ){
        [dict setObject:[NSNumber numberWithDouble:134.9745] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:17.0467] forKey:@"DEC"];
        NSLog(@" aug 4: %f", angle);
    }
    //AUG 5
    else if(angle > 2.339838  && angle <= 2.356640 ){
        [dict setObject:[NSNumber numberWithDouble:135.9375] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:16.7747] forKey:@"DEC"];
        NSLog(@" aug 5: %f", angle);
    }
    //AUG 6
    else if(angle > 2.356640 && angle <=  2.369220){
        [dict setObject:[NSNumber numberWithDouble:136.9005] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:16.4986] forKey:@"DEC"];
        NSLog(@" aug 6: %f", angle);
    }
    //AUG 7
    else if(angle >  2.369220 && angle <= 2.385937 ){
        [dict setObject:[NSNumber numberWithDouble:137.85] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:16.2189] forKey:@"DEC"];
        NSLog(@" aug 7: %f", angle);
    }
    //AUG 8
    else if(angle > 2.385937 && angle <= 2.402608 ){
        [dict setObject:[NSNumber numberWithDouble:138.804] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.9339] forKey:@"DEC"];
        NSLog(@" aug 8: %f", angle);
    }
    //AUG 9
    else if(angle > 2.402608  && angle <= 2.419236 ){
        [dict setObject:[NSNumber numberWithDouble:139.7535] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.6444] forKey:@"DEC"];
        NSLog(@" aug 9: %f", angle);
    }
    //AUG 10
    else if(angle > 2.419236 && angle <=  2.435821 ){
        [dict setObject:[NSNumber numberWithDouble:140.7] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.3519] forKey:@"DEC"];
        NSLog(@" aug 10: %f", angle);
    }
    //AUG 11
    else if(angle >  2.435821  && angle <= 2.452364 ){
        [dict setObject:[NSNumber numberWithDouble:141.6465] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:15.0544] forKey:@"DEC"];
        NSLog(@" aug 11: %f", angle);
    }
    //AUG 12
    else if(angle > 2.452364 && angle <= 2.468865 ){
        [dict setObject:[NSNumber numberWithDouble:142.5915] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.7525] forKey:@"DEC"];
        NSLog(@" aug 12: %f", angle);
    }
    //AUG 13
    else if(angle >  2.468865 && angle <= 2.485326 ){
        [dict setObject:[NSNumber numberWithDouble:143.529] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.4483] forKey:@"DEC"];
        NSLog(@" aug 13: %f", angle);
    }
    //AUG 14
    else if(angle > 2.485326 && angle <= 2.501747 ){
        [dict setObject:[NSNumber numberWithDouble:144.471] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:14.1389] forKey:@"DEC"];
        NSLog(@" aug 14: %f", angle);
    }
    //AUG 15
    else if(angle > 2.501747  && angle <=  2.518130){
        [dict setObject:[NSNumber numberWithDouble:145.4085] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:13.8258] forKey:@"DEC"];
        NSLog(@" aug 15: %f", angle);
    }
    //AUG 16
    else if(angle > 2.518130 && angle <= 2.534475 ){
        [dict setObject:[NSNumber numberWithDouble:146.337] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:13.5103] forKey:@"DEC"];
        NSLog(@" aug 16: %f", angle);
    }
    //AUG 17
    else if(angle >  2.534475 && angle <= 2.550783 ){
        [dict setObject:[NSNumber numberWithDouble:147.2715] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:13.1897] forKey:@"DEC"];
        NSLog(@" aug 17: %f", angle);
    }
    //AUG 18
    else if(angle > 2.550783 && angle <= 2.567054 ){
        [dict setObject:[NSNumber numberWithDouble:148.2045] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.8658] forKey:@"DEC"];
        NSLog(@" aug 18: %f", angle);
    }
    //AUG 19
    else if(angle >  2.567054 && angle <= 2.583291 ){
        [dict setObject:[NSNumber numberWithDouble:149.1285] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.54] forKey:@"DEC"];
        NSLog(@" aug 19: %f", angle);
    }
    //AUG 20
    else if(angle > 2.583291 && angle <= 2.599492 ){
        [dict setObject:[NSNumber numberWithDouble:150.0585] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:12.2094] forKey:@"DEC"];
        NSLog(@" aug 20: %f", angle);
    }
    //AUG 21
    else if(angle > 2.599492  && angle <= 2.615660 ){
        [dict setObject:[NSNumber numberWithDouble:150.9795] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:11.8756] forKey:@"DEC"];
        NSLog(@" aug 21: %f", angle);
    }
    //AUG 22
    else if(angle > 2.615660 && angle <= 2.631794 ){
        [dict setObject:[NSNumber numberWithDouble:151.896] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:11.54] forKey:@"DEC"];
        NSLog(@" aug 22: %f", angle);
    }
    //AUG 23
    else if(angle > 2.631794  && angle <= 2.647896 ){
        [dict setObject:[NSNumber numberWithDouble:152.8215] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:11.2] forKey:@"DEC"];
        NSLog(@" aug 23: %f", angle);
    }
    //AUG 24
    else if(angle > 2.647896 && angle <= 2.663967 ){
        [dict setObject:[NSNumber numberWithDouble:153.738] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:10.8569] forKey:@"DEC"];
        NSLog(@" aug 24: %f", angle);
    }
    //AUG 25
    else if(angle >  2.663967 && angle <=  2.680006){
        [dict setObject:[NSNumber numberWithDouble:154.65] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:10.5125] forKey:@"DEC"];
        NSLog(@" aug 25: %f", angle);
    }
    //AUG 26
    else if(angle > 2.680006 && angle <= 2.696015 ){
        [dict setObject:[NSNumber numberWithDouble:155.565] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:10.1639] forKey:@"DEC"];
        NSLog(@" aug 26: %f", angle);
    }
    //AUG 27
    else if(angle >  2.696015 && angle <= 2.711995 ){
        [dict setObject:[NSNumber numberWithDouble:156.483] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:9.8128] forKey:@"DEC"];
        NSLog(@" aug 27: %f", angle);
    }
    //AUG 28
    else if(angle > 2.711995 && angle <= 2.727947 ){
        [dict setObject:[NSNumber numberWithDouble:157.392] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:9.4603] forKey:@"DEC"];
        NSLog(@" aug 28: %f", angle);
    }
    //AUG 29
    else if(angle > 2.727947  && angle <= 2.743871 ){
        [dict setObject:[NSNumber numberWithDouble:158.304] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:9.1039] forKey:@"DEC"];
    NSLog(@" aug 29: %f", angle);
    }
    //AUG 30
    else if(angle > 2.743871 && angle <= 2.759768 ){
        [dict setObject:[NSNumber numberWithDouble:159.186] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:8.745] forKey:@"DEC"];
    NSLog(@" aug 30: %f", angle);
    }
    //AUG 31
    else if(angle > 2.759768  && angle <= 2.779586 ){
        [dict setObject:[NSNumber numberWithDouble:160.116] forKey:@"RA"];
        [dict setObject:[NSNumber numberWithDouble:8.3853] forKey:@"DEC"];
        NSLog(@" aug 31: %f", angle);
    }





  
    return dict;

}

@end
