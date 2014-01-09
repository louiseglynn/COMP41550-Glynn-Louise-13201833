//
//  CalcModel.h
//  Calc
//
//  Created by comp41550 on 08/01/2014.
//  Copyright (c) 2014 comp41550. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcModel : NSObject
- (void)setOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
@end
