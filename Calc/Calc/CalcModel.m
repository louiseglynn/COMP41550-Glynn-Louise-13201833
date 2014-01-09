//
//  CalcModel.m
//  Calc
//
//  Created by comp41550 on 08/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import "CalcModel.h"

@interface CalcModel ()
@property (nonatomic) double operand;
@property (nonatomic, strong) NSString *waitingOperation;
@property (nonatomic) double waitingOperand;
@property (nonatomic) double memoryNumber;
@end

@implementation CalcModel

- (void)performWaitingOperation
{
    if ([@"+" isEqualToString:self.waitingOperation])
    {
        self.operand = self.waitingOperand + self.operand;
    }
    else if ([@"−" isEqualToString:self.waitingOperation])
    {
        self.operand = self.waitingOperand - self.operand;
    }
    else if ([@"×" isEqualToString:self.waitingOperation])
    {
        self.operand = self.waitingOperand * self.operand;
    }
    else if ([@"÷" isEqualToString:self.waitingOperation])
    {
        self.operand = self.waitingOperand / self.operand;
    }
    
}

- (double)performOperation:(NSString *)operation
{
    if ([operation isEqualToString:@"√"])
    {
        self.operand = sqrt(self.operand);
    }
    else if ([operation isEqualToString:@"C"])
    {
        self.operand = 0;
    }
    else if ([operation isEqualToString:@"M+"])
    {
        NSLog(@"M+");
        self.memoryNumber = self.memoryNumber + self.operand;
    }
    else if ([operation isEqualToString:@"M-"])
    {
        NSLog(@"M+");
        self.memoryNumber = self.memoryNumber + self.operand;
    }
    else
    
    {
        [self performWaitingOperation];
        self.waitingOperand = self.operand;
        self.waitingOperation = operation;
    }
    return _operand;
}

@end
