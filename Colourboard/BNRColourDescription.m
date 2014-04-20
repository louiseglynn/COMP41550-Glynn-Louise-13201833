//
//  BNRColourDescription.m
//  Colourboard
//
//  Created by CSI Student on 20/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRColourDescription.h"

@implementation BNRColourDescription


-(instancetype)init{
    
    self = [super init];
    
    if(self){
        _colour = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        
        _name = @"Blue";
        
    }
    
    return self;
    
}

@end
