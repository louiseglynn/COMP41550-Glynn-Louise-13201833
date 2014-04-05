//
//  BNROwnedAppliance.m
//  Appliances
//
//  Created by CSI Student on 03/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNROwnedAppliance.h"

@interface BNROwnedAppliance()
{
    NSMutableSet *_ownerNames;
}
@end


@implementation BNROwnedAppliance

-(instancetype)initWithProductName:(NSString *)pn firstOwnerName:(NSString *)n{
    self = [super initWithProductName:pn];
    
    if(self){
        
        _ownerNames = [[NSMutableSet alloc]init];
        
        if(n){
            [_ownerNames addObject:n];
        }
    }
    
    return self;
}

-(instancetype)initWithProductName:(NSString *)p
{
    return [self initWithProductName:p firstOwnerName:nil];
}

-(void)addOwnerNamesObject:(NSString *)n{
    
}
-(void)removeOwnerNamesObject:(NSString *)n{
    
}

@end
