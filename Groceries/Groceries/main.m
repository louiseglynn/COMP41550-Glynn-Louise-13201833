//
//  main.m
//  Groceries
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *groceryList = [NSMutableArray array];
        
        [groceryList addObject:@"Loaf of bread"];
        [groceryList addObject:@"Container of milk"];
        [groceryList addObject:@"Stick of buter"];
        
        for(NSString *item in groceryList){
            
            NSLog(@"Item: %@", item);

        }
        
        
    }
    return 0;
}

