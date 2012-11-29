//
//  BigCalculator4.h
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigCalculator4 : NSObject


-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

-(void) addCalculationProgressHandlerForTarget:(id)obj selector:(SEL)handler;
-(void) addCalculationResultHandlerForTarget:(id)obj selector:(SEL)handler;

@end
