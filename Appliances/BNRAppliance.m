//
//  BNRAppliance.m
//  Appliances
//
//  Created by CSI Student on 03/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRAppliance.h"

@implementation BNRAppliance



/*-(instancetype)init
{
    self = [super init];
    
    if(self){
        _voltage = 20;
    }
    
    return self;
}*/


-(instancetype)initWithProductName:(NSString *)pn
{
    self = [super init];
    
    if(self){
        _productName = [pn copy];
        
        _voltage = 20;
    }
    
    return self;
}

-(instancetype)init
{
    return [self initWithProductName:@"Unknown"];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %d volts>", self.productName, self.voltage];
}

@end
