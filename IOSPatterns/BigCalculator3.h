//
//  BigCalculator3.h
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *kBigCalculatorProgressChangeNotification = @"kBigCalculatorProgressChangeNotification";
static NSString *kBigCalculatorCalculationCompleteNotification = @"kBigCalculatorCalculationCompleteNotification";

@interface BigCalculator3 : NSObject

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

@end
