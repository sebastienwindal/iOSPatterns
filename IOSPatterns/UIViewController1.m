//
//  UIViewController1.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "UIViewController1.h"
#import "BigCalculator1.h"

// we are specifying we are a BigCalculatorDelegate
@interface UIViewController1 () <BigCalculatorDelegate>
{
    float _progress;
    float _result;
}
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong) BigCalculator1 *bigCalculator;

@end

@implementation UIViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // we set ourselves as the delegate of big calculator
    self.bigCalculator = [[BigCalculator1 alloc] init];
    self.bigCalculator.delegate = self;
    
    [self.bigCalculator startBigCalculationWithNumber:7.0 andNumber:5.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BigCalculatorDelegate

// we implement the BigCalculatorDelegate methods, because we set ourslef as bigCalculator.delegate we will be
// called by big calculator

-(void) bigCalculator:(BigCalculator1 *)calculator madeProgressOnCalculation:(float)percentProgress
{
    // update UI to increase progress (in foreground thread!)
    _progress = percentProgress;
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
    
}

-(void) bigCalculator:(BigCalculator1 *)calculator didFinishOperationWithResult:(float)result
{
    // update UI to show calculation result (in foreground thread!)
    _result = result;
    _progress = 1.0f;
    [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
}

-(void) updateUI
{
    self.progressView.progress = _progress;
    if (_progress == 1.0f)
        self.resultLabel.text = [NSString stringWithFormat:@"%f", _result];
}

@end
