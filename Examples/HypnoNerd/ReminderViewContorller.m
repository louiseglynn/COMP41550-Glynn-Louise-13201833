//
//  ReminderViewContorller.m
//  HypnoNerd
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ReminderViewContorller.h"

@interface ReminderViewContorller ()

@property (nonatomic, weak) IBOutlet UIDatePicker *picker;

@end

@implementation ReminderViewContorller

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        self.tabBarItem.title = @"Reminder";
        
        UIImage *image = [UIImage imageNamed:@"Time.png"];
        
        self.tabBarItem.image = image;
        
    }
    
    return self;
}

- (IBAction)addReminder:(id)sender{
    NSDate *date = self.picker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UILocalNotification *note = [[UILocalNotification alloc]init];
    
    note.alertBody = @"Hypnotise me";
    note.fireDate = date;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:note];
}

@end
