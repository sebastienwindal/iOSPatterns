//
//  BigCalculator1.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "BigCalculator1.h"

@implementation BigCalculator1
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
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self madeProgressOnCalculation:0.25];
    }
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self madeProgressOnCalculation:0.5];
    }

    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self madeProgressOnCalculation:0.75];
    }

    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self madeProgressOnCalculation:1.0];
    }
    // we are done publish the result of our calculation...
    [self.delegate bigCalculator:self didFinishOperationWithResult:(_number1 + _number2)];
}

@end
