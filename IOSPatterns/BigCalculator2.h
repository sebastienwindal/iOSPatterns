//
//  BigCalculator2.h
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigCalculator2 : NSObject

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

@property (nonatomic) float calculationProgress;
@property (nonatomic) float calculationResult;

@end
