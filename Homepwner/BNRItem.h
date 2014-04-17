//
//  BNRItem.h
//  Homepwner
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *number;

-(instancetype)initWithName:(NSString *)name andNumber:(NSString *)number;

@end
