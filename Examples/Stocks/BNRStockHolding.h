//
//  BNRStockHolding.h
//  Stocks
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRStockHolding : NSObject
{
    float _purchaseSharePrice;
    float _currentSharePrice;
    int _numberOfShares;
}

-(void)setPurchaseSharePrice:(float)p;
-(void)setCurrentSharePrice:(float)c;
-(void)setNumberOfShares:(int)n;

-(float)purchaseSharePrice;
-(float)currentSharePrice;
-(int)numberOfShares;

-(float)costInDollars;
-(float)valueInDollars;

@end
