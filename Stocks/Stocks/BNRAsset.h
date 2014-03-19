//
//  BNRAsset.h
//  Stocks
//
//  Created by CSI Student on 16/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNREmployee;

@interface BNRAsset : NSObject


@property (nonatomic, copy) NSString *label;
@property (nonatomic) unsigned int resaleValue;
@property (nonatomic, weak) BNREmployee *employee; //an asset should not own its holder = weak reference prevents strong reference cycle/source of memory leak




@end
