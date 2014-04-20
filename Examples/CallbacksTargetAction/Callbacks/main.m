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
        
                
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop]run];
        
    }
    return 0;
}

