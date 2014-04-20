//
//  BNRItemStore.h
//  Homepwner
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>




@class BNRItem;


@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+(instancetype)sharedStore;
//-(void)createItem:(BNRItem *)item;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem *)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(BOOL)saveChanges;

@end
