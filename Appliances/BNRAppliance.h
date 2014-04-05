//
//  BNRAppliance.h
//  Appliances
//
//  Created by CSI Student on 03/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRAppliance : NSObject

@property (nonatomic, copy) NSString *productName;
@property (nonatomic) int voltage;

// The designated initializer
-(instancetype)initWithProductName:(NSString *)pn;

@end
