//
//  Message.h
//  Chat
//
//  Created by CSI Student on 23/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSDate * message_date;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * message_id;
@property (nonatomic, retain) NSString * user_name;

@end
