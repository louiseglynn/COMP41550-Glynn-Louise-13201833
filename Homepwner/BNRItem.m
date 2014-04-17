//
//  BNRItem.m
//  Homepwner
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem



-(instancetype)initWithName:(NSString *)name andNumber:(NSString *)number{
    
    self = [super init];
    
    self.name = name;
    self.number = number;
    
    return self;
}


@end
