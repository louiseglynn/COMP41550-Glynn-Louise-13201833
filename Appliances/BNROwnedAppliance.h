//
//  BNROwnedAppliance.h
//  Appliances
//
//  Created by CSI Student on 03/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"

@interface BNROwnedAppliance : BNRAppliance

@property (readonly) NSSet *ownerNames;

//The designated initializer
-(instancetype)initWithProductName:(NSString *)pn firstOwnerName:(NSString *)n;

-(void)addOwnerNamesObject:(NSString *)n;
-(void)removeOwnerNamesObject:(NSString *)n;

@end
