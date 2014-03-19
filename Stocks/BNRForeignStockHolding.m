//
//  BNRForeignStockHolding.m
//  Stocks
//
//  Created by CSI Student on 16/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRForeignStockHolding.h"

@implementation BNRForeignStockHolding

-(float)costInDollars{
    
    return [self purchaseSharePrice] * [self conversionRate] * [self numberOfShares];
    
}
-(float)valueInDollars{
    
    return [self currentSharePrice] * [self conversionRate] * [self numberOfShares];
    
}

@end
