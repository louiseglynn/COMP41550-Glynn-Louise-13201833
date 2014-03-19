//
//  CalcViewController.m
//  Calc
//
//  Created by comp41550 on 08/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "CalcViewController.h"

@interface CalcViewController ()
@property (nonatomic) BOOL isInTheMiddleOfEnteringANumber;
@property (weak, nonatomic) IBOutlet UILabel *calcDisplay;
@property (nonatomic, strong) CalcModel *calcModel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *keyBackgroundViews;


- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
@end

@implementation CalcViewController

- (CalcModel *)calcModel
{
    if (!_calcModel)
    {
        _calcModel = [CalcModel new];
    }
    return _calcModel;
}

- (BOOL)isIsInTheMiddleOfEnteringANumber
{
    if (!_calcModel)
    {
        // init calc states
        self.calcDisplay.text = @"0";
        _isInTheMiddleOfEnteringANumber = NO;
    }
    return _isInTheMiddleOfEnteringANumber;
}

- (void)digitPressed:(UIButton *)sender
{
    //NSLog(@"digit pressed");
    NSString *digit = sender.titleLabel.text;
    
    if (self.isInTheMiddleOfEnteringANumber)
    {
        self.calcDisplay.text = [self.calcDisplay.text stringByAppendingString:digit];
    }
    else
    {
        self.calcDisplay.text = sender.titleLabel.text;
        self.isInTheMiddleOfEnteringANumber = YES;
    }
}

- (void)operationPressed:(UIButton *)sender
{
    //NSLog(@"operation pressed");
    if (self.isInTheMiddleOfEnteringANumber)
    {
        self.isInTheMiddleOfEnteringANumber = NO;
        [self.calcModel setOperand:[self.calcDisplay.text doubleValue]];
    }
    NSString *operation = sender.titleLabel.text;
    double result = [self.calcModel performOperation:operation];
    self.calcDisplay.text = [NSString stringWithFormat:@"%g", result];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // pretty display stuff
    for (UIView *view in self.keyBackgroundViews)
    {
        view.layer.borderColor = [UIColor blackColor].CGColor;
        view.layer.borderWidth = 0.5;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    self.calcModel = nil;
}

@end
