//
//  ToDoItem.h
//  ToDoList
//
//  Created by CSI Student on 17/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

- (void) markAsCompleted:(BOOL)isComplete;

@end
