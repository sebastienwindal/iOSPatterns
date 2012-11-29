//
//  BigCalculator5.h
//  IOSPatterns
//
//  Created by Sebastien on 11/29/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^progressHandler)(float percentProgress);
typedef void (^completionHandler)(float result);

@interface BigCalculator5 : NSObject

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

-(void) addCalculationProgressHandler:(progressHandler)handler;
-(void) addCalculationResultHandler:(completionHandler)handler;

@end
