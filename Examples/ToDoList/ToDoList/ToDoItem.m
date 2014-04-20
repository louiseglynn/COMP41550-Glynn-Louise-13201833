//
//  ToDoItem.m
//  ToDoList
//
//  Created by CSI Student on 17/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ToDoItem.h"

@interface ToDoItem ()

@property NSDate *completionDate;

@end


@implementation ToDoItem

- (void) markAsCompleted:(BOOL)isComplete{
    
    self.completed = isComplete;
}

- (void) setCompletionDate {
    
    if(self.completed){
        self.completionDate = [NSDate date];
        
    }else{
        self.completionDate = nil;
    }
}



@end
