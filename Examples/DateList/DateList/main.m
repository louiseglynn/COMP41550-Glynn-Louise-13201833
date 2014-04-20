//
//  main.m
//  DateList
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *now = [NSDate date];
        NSDate *tomorrow = [now dateByAddingTimeInterval:24*60*60];
        NSDate *yesterday = [now dateByAddingTimeInterval:-24*60*60];
        
        //NSArray *dateList = @[now, tomorrow, yesterday];
        
        //NSMutableArray *dateList = [NSMutableArray array];
        NSMutableArray *dateList = [[NSMutableArray alloc]init];

        
        [dateList addObject:now];
        [dateList addObject:tomorrow];
        
        
        [dateList insertObject:yesterday atIndex:0];
        
        
        
        /*NSLog(@"The first date is %@", dateList[0]);
        NSLog(@"The second date is %@", dateList[1]);
        NSLog(@"The third date is %@", dateList[2]);*/
        
        NSLog(@"There are %lu dates in the array", [dateList count]);
        
        
        //NSUInteger counter = [dateList count];
        
        /*for(int i=0; i< [dateList count]; i++){
            
            NSLog(@" %@", dateList[i]);
         
        }*/
        
        for(NSDate *d in dateList){
            NSLog(@"Here is a date %@", d);
        }
        
        [dateList removeObjectAtIndex:0];
        
        
    }
    return 0;
}

