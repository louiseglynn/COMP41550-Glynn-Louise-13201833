//
//  BNRLogger.m
//  Callbacks
//
//  Created by CSI Student on 22/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRLogger.h"

@implementation BNRLogger

-(NSString *)lastTimeString
{
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLog(@"created date Formattter");
        
    }
    return [dateFormatter stringFromDate:self.lastTime];
}

-(void)updateLastTime:(NSTimer *)t
{
    NSDate *now = [NSDate date];
    [self setLastTime:now];
    NSLog(@"Just set time to %@", self.lastTimeString);
}

@end
