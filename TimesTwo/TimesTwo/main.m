//
//  main.m
//  TimesTwo
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //NSDate *currentTime = nil;
        
        NSDate *currentTime = [NSDate date];
        NSLog(@"crrentTimes value is %p", currentTime);
        
        
        sleep(2);
        
        currentTime = [NSDate date];
        NSLog(@"crrentTimes value is %p", currentTime);
        
        
        
        NSString *testSentence = @"This is a sentence.";
        
        ///NSString *testWord = @"sentence";
        
        //NSRange match = [testSentence rangeOfString:@"Sentence"] case sensitive search
        
        NSRange match = [testSentence rangeOfString:@"Sentence" options:NSCaseInsensitiveSearch];
        
        if(match.location == NSNotFound){
            NSLog(@"they don't match");
        }
        else{
            
            NSLog(@"they do match");
            
            NSString *testSubString = [testSentence substringWithRange:match];
            
            NSLog(@"%@", testSubString);
            
        }
        
        
        
        

        
    }
    return 0;
}

