//
//  main.m
//  VowelMovement
//
//  Created by CSI Student on 30/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ArrayEnumerationBlock)(id, NSUInteger, BOOL *);

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray * original = @[@"Sauerkraut", @"Raygun", @"Big Nerd Ranch", @"Mississippi"];
        NSMutableArray * devowelized = [NSMutableArray array];
        NSArray * vowels = @[@"a", @"e", @"i", @"o", @"u"];
        
        //void (^devowelizer)(id, NSUInteger, BOOL *);
        //ArrayEnumerationBlock devowelizer;
        
        //devowelizer = ^(id str, NSUInteger i, BOOL *stop){
        
        
        [original enumerateObjectsUsingBlock:^(id str, NSUInteger i, BOOL *stop){
            NSRange yRange = [str rangeOfString:@"y"
                                        options:NSCaseInsensitiveSearch];
            
            if(yRange.location !=NSNotFound){
                *stop = YES;
                return;
            }
            
            NSMutableString *newString = [NSMutableString stringWithString:str];
            
            for(NSString *s in vowels){
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s
                                           withString:@""
                                              options:NSCaseInsensitiveSearch
                                                range:fullRange];
            }
            
            [devowelized addObject:newString];
        }
        ];
        NSLog(@"devowelized strings %@", devowelized)
        ;
    }
    return 0;
}

