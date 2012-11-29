//
//  ViewController3.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "ViewController3.h"
#import "BigCalculator3.h"

@interface ViewController3 ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong) BigCalculator3 *bigCalculator;
@end

@implementation ViewController3

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
    
    // subscribe to notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculatorProgressChanged:) name:kBigCalculatorProgressChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calculatorCompletedCalculation:) name:kBigCalculatorCalculationCompleteNotification object:nil];
    
    self.bigCalculator = [[BigCalculator3 alloc] init];
    
    [self.bigCalculator startBigCalculationWithNumber:7.0 andNumber:5.0];
}

-(void) calculatorProgressChanged:(NSNotification *)notification
{
    float value = [notification.object floatValue];
    // update the UI on the Main thread!
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = value;
    });
}

-(void) calculatorCompletedCalculation:(NSNotification *)notification
{
    NSString *str = [NSString stringWithFormat:@"%f", [notification.object floatValue]];
    // update the UI on the Main thread!
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = 1.0f;
        self.resultLabel.text = str;
    });
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
