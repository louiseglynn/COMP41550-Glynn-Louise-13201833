//
//  main.m
//  Appliances
//
//  Created by CSI Student on 03/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BNRAppliance *a = [[BNRAppliance alloc]init];
        
        NSLog(@"a is a%@", a);
        
        [a setProductName:@"Washing Machine"];
        [a setVoltage:240];
        
        NSLog(@"a is a%@", a);
        
    }
    return 0;
}

