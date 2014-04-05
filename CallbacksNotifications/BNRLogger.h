//
//  BNRLogger.h
//  Callbacks
//
//  Created by CSI Student on 22/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRLogger : NSObject
<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

{
    NSMutableData *incomingData;
}
@property (nonatomic) NSDate *lastTime;
-(NSString *)lastTimeString;
-(void)updateLastTime:(NSTimer *)t;
@end
