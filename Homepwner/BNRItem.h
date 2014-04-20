//
//  BNRItem.h
//  Homepwner
//
//  Created by CSI Student on 19/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BNRItem : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * number;
@property (nonatomic, strong) NSString * imageKey;
@property (nonatomic) double orderingValue;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSDate *dateCreated;


-(void)setThumbnailFromImage:(UIImage *)image;

@end
