//
//  ViewController5.m
//  IOSPatterns
//
//  Created by Sebastien on 11/29/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "ViewController5.h"
#import "BigCalculator5.h"

@interface ViewController5 ()

@property (nonatomic, strong) BigCalculator5 *bigCalculator;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ViewController5

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
    
    self.bigCalculator = [[BigCalculator5 alloc] init];
    
    [self.bigCalculator addCalculationProgressHandler:^(float percentProgress) {
        // update UI on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = percentProgress;
        });
    }];
    
    [self.bigCalculator addCalculationResultHandler:^(float result) {
        // update UI on main thread...
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = 1.0f;
            self.resultLabel.text = [NSString stringWithFormat:@"%f", result];
        });
    }];
    
    [self.bigCalculator startBigCalculationWithNumber:7.0f andNumber:5.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
