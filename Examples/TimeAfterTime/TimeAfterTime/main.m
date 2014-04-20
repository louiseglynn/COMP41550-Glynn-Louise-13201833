//
//  main.m
//  TimeAfterTime
//
//  Created by CSI Student on 14/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *now = [[NSDate alloc] init];
        
        //NSDate *now = [NSDate date];
        NSLog(@"This NSDate object lives at %p", now);
        NSLog(@"The date is %@", now);
        
        double seconds = [now timeIntervalSince1970];
        
        NSLog(@"The time since 1970 is: %f", seconds);
        
        //error messages will be issues by following
        //double testSeconds = [NSDate timeIntervalSince1970]; an instance method when a class method should be called
        //NSDate *testNow = [now date]; a class method when an instance method should be called
        //double testSeconds = [now fooIntervalSince1970]; a miss spelled instance method
        //double testSeconds = [now timeintervalSince1970]; //should be camel case timeInterval
        
        NSHost *host = [NSHost currentHost];
        NSLog(@"This NSHost object is %@", host);
        
        NSString *tes = [host localizedName];
        NSLog(@"The localised name is %@", tes);
        
        NSDate *later = [now dateByAddingTimeInterval:1000000];
        NSLog(@"The date 100000 seconds from now is %@", later);
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSLog(@"My calender is %@", [cal calendarIdentifier]);
        
        unsigned long day = [cal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
        
        NSLog(@"This is day %lu of the month", day);
        
        NSDate *laterDate = [NSDate date];
        
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:1980];
        [comps setMonth:12];
        [comps setDay:31];
        
        NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *dateOfBirth = [g dateFromComponents:comps];
        
        double secondsSinceEarlierDate = [laterDate timeIntervalSinceDate:dateOfBirth];
        
        NSLog(@"Seconds since I was born: %f", secondsSinceEarlierDate);
        
        
    }
    return 0;
}


