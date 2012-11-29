//
//  BigCalculator5.m
//  IOSPatterns
//
//  Created by Sebastien on 11/29/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "BigCalculator5.h"

@interface BigCalculator5()
{
    float _number1;
    float _number2;
}

@property (nonatomic, strong) NSMutableArray *progressHandlers; // array of progressHandler objects
@property (nonatomic, strong) NSMutableArray *completionHandlers; // array of completionHandler objects.

@end


@implementation BigCalculator5

-(NSMutableArray *) progressHandlers
{
    if (_progressHandlers == nil)
        _progressHandlers = [[ NSMutableArray alloc] init];

    return _progressHandlers;
}

-(NSMutableArray *) completionHandlers
{
    if (_completionHandlers == nil)
        _completionHandlers = [[ NSMutableArray alloc] init];
    
    return _completionHandlers;
}

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2
{
    _number1 = number1;
    _number2 = number2;
    [self performSelectorInBackground:@selector(doBackgroundWork) withObject:nil];
}

-(void) doBackgroundWork
{
    // note the argument is really index 2, index 0 is the object, and index 1 is the selector.
    // Kind of obscure.
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        progressHandler handler = obj;
        handler(0.25);
    }];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        progressHandler handler = obj;
        handler(0.5);
    }];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        progressHandler handler = obj;
        handler(0.75);
    }];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        progressHandler handler = obj;
        handler(1.0f);
    }];
    
    // we are done publish the result of our calculation...
    [self.completionHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        completionHandler handler = obj;
        handler(pow(_number1, _number2));
    }];
}

-(void) addCalculationProgressHandler:(progressHandler)handler
{
    [self.progressHandlers addObject:handler];
}

-(void) addCalculationResultHandler:(completionHandler)handler
{
    [self.completionHandlers addObject:handler];
}


@end
