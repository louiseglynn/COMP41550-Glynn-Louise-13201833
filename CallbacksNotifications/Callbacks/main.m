//
//  main.m
//  Callbacks
//
//  Created by CSI Student on 22/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BNRLogger *logger = [[BNRLogger alloc]init];
        
        
        
        //[[NSNotificationCenter defaultCenter]addObserver:logger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserverForName:@"test" object:logger queue:nil usingBlock:^(NSNotification * note){
            NSLog(@"The system time zone has changed!");
        }];

                
        NSURL *url =[NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request delegate:logger startImmediately:YES];
        
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop]run];
        
    }
    return 0;
}

