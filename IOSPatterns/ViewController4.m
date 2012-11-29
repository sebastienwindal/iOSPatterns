//
//  ViewController4.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "ViewController4.h"
#import "BigCalculator4.h"

@interface ViewController4 ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong) BigCalculator4 *bigCalculator;

@end

@implementation ViewController4

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
    
    self.bigCalculator = [[BigCalculator4 alloc] init];
    
    [self.bigCalculator addCalculationProgressHandlerForTarget:self selector:@selector(calculationProgressChanged:)];
    [self.bigCalculator addCalculationResultHandlerForTarget:self selector:@selector(calculationCompletedWithResult:)];
    
    [self.bigCalculator startBigCalculationWithNumber:5.0 andNumber:7.0];
}

-(void) calculationProgressChanged:(float)progress
{
    // update UI on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });
}

-(void) calculationCompletedWithResult:(float) result
{
    // update UI on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = 1.0f;
        self.resultLabel.text = [NSString stringWithFormat:@"%f", result];
    });
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
