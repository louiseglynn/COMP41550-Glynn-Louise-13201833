//
//  main.m
//  Stocks
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRForeignStockHolding.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        BNRStockHolding *b1 = [[BNRStockHolding alloc]init];
        [b1 setPurchaseSharePrice:2.30];
        [b1 setCurrentSharePrice:4.50];
        [b1 setNumberOfShares:40];
        
        BNRStockHolding *b2 = [[BNRStockHolding alloc]init];
        [b2 setPurchaseSharePrice:12.19];
        [b2 setCurrentSharePrice:10.56];
        [b2 setNumberOfShares:90];

        
        
        BNRStockHolding *b3 = [[BNRStockHolding alloc]init];
        [b3 setPurchaseSharePrice:45.20];
        [b3 setCurrentSharePrice:49.51];
        [b3 setNumberOfShares:210];
        
        
        BNRForeignStockHolding *b4 = [[BNRForeignStockHolding alloc]init];
        [b4 setPurchaseSharePrice:2.3];
        [b4 setCurrentSharePrice: 4.5];
        [b4 setNumberOfShares:40];
        [b4 setConversionRate:0.94];

        [arr addObject:b1];
        [arr addObject:b2];
        [arr addObject:b3];
        [arr addObject:b4];
        
        
        
        for(BNRStockHolding *b in arr){
            
            NSLog(@"Purchased Share Price: %.2f, Current Share Price: %.2f, Number of Shares: %d, Cost in Dollars: %.2f, Value in Dollars: %.2f", [b purchaseSharePrice], [b currentSharePrice], [b numberOfShares], [b costInDollars], [b valueInDollars]);
            
        }
        
        
        
    }
    return 0;
}

