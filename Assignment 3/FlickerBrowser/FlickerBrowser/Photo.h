//
//  Photo.h
//  FlickerBrowser
//
//  Created by CSI Student on 20/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Photo : NSManagedObject

@property (nonatomic, retain)   NSString *unique;
@property (nonatomic, retain)   NSString *title;
@property (nonatomic, retain)   NSString *subtitle;
@property (nonatomic, retain)   UIImage *thumbnail;
@property (nonatomic, retain)   NSString *owner;
@property (nonatomic, retain)   NSString *imageURL;

@end
