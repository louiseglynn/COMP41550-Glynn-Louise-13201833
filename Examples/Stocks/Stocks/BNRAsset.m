//
//  BNRAsset.m
//  Stocks
//
//  Created by CSI Student on 16/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRAsset.h"
#import "BNREmployee.h"

@implementation BNRAsset



-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: $%d assigned to %@", self.label, self.resaleValue, self.employee];
}

-(void)dealloc{
    NSLog(@"deallocating %@", self);
}

@end
