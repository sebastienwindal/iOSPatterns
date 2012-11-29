//
//  BigCalculator3.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "BigCalculator3.h"

@implementation BigCalculator3
{
    float _number1;
    float _number2;
}

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2
{
    _number1 = number1;
    _number2 = number2;
    [self performSelectorInBackground:@selector(doBackgroundWork) withObject:nil];
}

-(void) doBackgroundWork
{
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [[NSNotificationCenter defaultCenter] postNotificationName:kBigCalculatorProgressChangeNotification object:@(0.25) userInfo:nil];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [[NSNotificationCenter defaultCenter] postNotificationName:kBigCalculatorProgressChangeNotification object:@(0.5) userInfo:nil];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [[NSNotificationCenter defaultCenter] postNotificationName:kBigCalculatorProgressChangeNotification object:@(0.75) userInfo:nil];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [[NSNotificationCenter defaultCenter] postNotificationName:kBigCalculatorProgressChangeNotification object:@(0.1) userInfo:nil];
    
    // we are done publish the result of our calculation...
    [[NSNotificationCenter defaultCenter] postNotificationName:kBigCalculatorCalculationCompleteNotification object:@(_number1 / _number2) userInfo:nil];

}

@end
