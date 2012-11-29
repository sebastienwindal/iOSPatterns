//
//  BigCalculator2.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "BigCalculator2.h"

@implementation BigCalculator2
{
    float _number1;
    float _number2;
}

-(id) init
{
    self = [super init];
    if (self) {
        self.calculationProgress = 0.0f;
    }
    return self;
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
    self.calculationProgress = 0.25;
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    self.calculationProgress = 0.5f;
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    self.calculationProgress = 0.75f;
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    self.calculationProgress = 1.0f;
    
    // we are done publish the result of our calculation...
    self.calculationResult = _number1 * _number2;
}


@end
