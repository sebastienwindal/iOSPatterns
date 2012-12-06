//
//  BigCalculator4.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "BigCalculator4.h"

@interface BigCalculator4()
{
    float _number1;
    float _number2;
}

@property (nonatomic, strong) NSMutableArray *progressHandlers; // array of NSInvocation
@property (nonatomic, strong) NSMutableArray *completionHandlers; // array of NSInvocation

@end

@implementation BigCalculator4

-(NSMutableArray *) progressHandlers
{
    if (_progressHandlers == nil)
        _progressHandlers = [[NSMutableArray alloc] init];
    return _progressHandlers;
}

-(NSMutableArray *) completionHandlers
{
    if (_completionHandlers == nil)
        _completionHandlers = [[NSMutableArray alloc] init];
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
        NSInvocation *invocation = obj;
        float progress = 0.25;
        [invocation setArgument:&progress atIndex:2];
        [invocation invoke];
    }];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSInvocation *invocation = obj;
        float progress = 0.5;
        [invocation setArgument:&progress atIndex:2];
        [invocation invoke];
    }];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSInvocation *invocation = obj;
        float progress = 0.75;
        [invocation setArgument:&progress atIndex:2];
        [invocation invoke];
    }];
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    [self.progressHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSInvocation *invocation = obj;
        float progress = 1.0;
        [invocation setArgument:&progress atIndex:2];
        [invocation invoke];
    }];
    
    // we are done publish the result of our calculation...
    [self.completionHandlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSInvocation *invocation = obj;
        float result = _number1 - _number2;
        [invocation setArgument:&result atIndex:2];
        [invocation invoke];
    }];
}


-(void) addCalculationProgressHandlerForTarget:(id)obj selector:(SEL)handler
{
    NSMethodSignature *aSignature;
    aSignature = [[obj class] instanceMethodSignatureForSelector:handler];
    
    NSInvocation * invocation = [NSInvocation
                                   invocationWithMethodSignature:aSignature];
    
    invocation.target = obj;
    invocation.selector = handler;
    
    [self.progressHandlers addObject:invocation];
}

-(void) addCalculationResultHandlerForTarget:(id)obj selector:(SEL)handler
{
    NSMethodSignature *aSignature;
    aSignature = [[obj class] instanceMethodSignatureForSelector:handler];
    
    NSInvocation * invocation = [NSInvocation
                                 invocationWithMethodSignature:aSignature];
    
    invocation.target = obj;
    invocation.selector = handler;
    
    [self.completionHandlers addObject:invocation];
}

@end
