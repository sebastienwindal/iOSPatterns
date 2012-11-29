//
//  BigCalculator1.h
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import <Foundation/Foundation.h>


@class BigCalculator1;

@protocol BigCalculatorDelegate <NSObject>

@required

-(void) bigCalculator:(BigCalculator1 *)calculator didFinishOperationWithResult:(float)result;

@optional

-(void) bigCalculator:(BigCalculator1 *)calculator madeProgressOnCalculation:(float)percentProgress;

@end


@interface BigCalculator1 : NSObject

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

@property (nonatomic, weak) id<BigCalculatorDelegate> delegate;

@end
