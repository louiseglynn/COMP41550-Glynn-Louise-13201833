//
//  BNRStockHolding.m
//  Stocks
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRStockHolding.h"

@implementation BNRStockHolding

-(void)setPurchaseSharePrice:(float)p{
    
    _purchaseSharePrice = p;
}
-(void)setCurrentSharePrice:(float)c{
    
    _currentSharePrice = c;
    
}
-(void)setNumberOfShares:(int)n{
    
    _numberOfShares = n;
    
}

-(float)purchaseSharePrice{
    
    return _purchaseSharePrice;
}
-(float)currentSharePrice{
    
    return _currentSharePrice;
}
-(int)numberOfShares{
    
    return _numberOfShares;
}

-(float)costInDollars{
    
    return [self purchaseSharePrice] * [self numberOfShares];
    
}
-(float)valueInDollars{
    
    return [self currentSharePrice] * [self numberOfShares];
    
}
@end
