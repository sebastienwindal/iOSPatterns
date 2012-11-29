//
//  ViewController2.m
//  IOSPatterns
//
//  Created by Sebastien on 11/28/12.
//  Copyright (c) 2012 Sebastien. All rights reserved.
//

#import "ViewController2.h"
#import "BigCalculator2.h"

@interface ViewController2 ()

@property (nonatomic, strong) BigCalculator2 *bigCalculator;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation ViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setBigCalculator:(BigCalculator2 *)bigCalculator
{
    // unsubscribe from the old object
    [_bigCalculator removeObserver:self forKeyPath:@"calculationProgress"];
    [_bigCalculator removeObserver:self forKeyPath:@"calculationResult"];
    
    _bigCalculator = bigCalculator;
    
    // subscribe to new object
    // options is set to NSKeyValueObservingOptionNew, so the change dictionary in the
    // observalueForKeyPath:ofObject:change:context: callback will contain the changed value
    // at the NSKeyValueChangeNewKey key.
    [self.bigCalculator addObserver:self forKeyPath:@"calculationProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.bigCalculator addObserver:self forKeyPath:@"calculationResult" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.bigCalculator = [[BigCalculator2 alloc] init];
    [self.bigCalculator startBigCalculationWithNumber:7.0f andNumber:5.0f];
    self.progressView.progress = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) dealloc
{
    // object will not be freed unless you unsubscrive from KVO
    // which is achieved simply by setting the objet to nil (see what setBigCalculator: is doing.)
    self.bigCalculator = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{

    if ([keyPath isEqualToString:@"calculationProgress"]) {
        // update ui (from the UI Thread!)
        dispatch_async(dispatch_get_main_queue(), ^{
            float value = [change[NSKeyValueChangeNewKey] floatValue];
            self.progressView.progress = value;
        });
    } else if ([keyPath isEqualToString:@"calculationResult"]) {
        // update ui (from the UI Thread!)
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.progress = 1.0f;
            NSString *str = [NSString stringWithFormat:@"%f", [change[NSKeyValueChangeNewKey] floatValue]];
            self.resultLabel.text = str;
        });
    }
    
}

@end
