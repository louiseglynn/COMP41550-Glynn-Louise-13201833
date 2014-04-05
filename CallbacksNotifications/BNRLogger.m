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

//called each time a chunk of data arrives
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    NSLog(@"received %lu bytes", [data length]);
    
    if(!incomingData)
    {
        incomingData = [[NSMutableData alloc]init];
        
    }
    
    [incomingData appendData:data];
}

//Called when the last chunk has been processed
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Got it all!");
    NSString *string = [[NSString alloc]initWithData:incomingData
                                            encoding:NSUTF8StringEncoding];
    incomingData = nil;
    
    NSLog(@"string has %lu characters", [string length]);
    
    NSLog(@"the whole string is %@", string);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    NSLog(@"connection failed: %@", [error localizedDescription]);
    incomingData = nil;
}

-(void)zoneChange:(NSNotification *)note
{
    NSLog(@"The system time zone has changed!");
}

@end
