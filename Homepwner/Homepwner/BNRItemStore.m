//
//  BNRItemStore.m
//  Homepwner
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"



@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

-(instancetype)initPrivate{
    
    
    
    self = [super init];
    
    if(self){
        
        _privateItems = [[NSMutableArray alloc]init];
    }
    
    return self;
    
}

+(instancetype)sharedStore{
    
    
    
    static BNRItemStore *sharedStore = nil;
    
    if(!sharedStore){
        
        sharedStore = [[self alloc]initPrivate];
    }
    
    return sharedStore;
}


-(instancetype)init{
    @throw [NSException exceptionWithName:@"singleton" reason:@"Use + [BNRItem sharedStore]" userInfo:nil];
    return nil;
}

-(void)createItem:(BNRItem *)item{
  
    [self.privateItems addObject:item];
   
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex
               toIndex:(NSUInteger)toIndex{
    
    if(fromIndex == toIndex){
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
    
    
    
}

-(NSArray *)allItems{
    
    return self.privateItems;
}

-(void)removeItem:(BNRItem *)item{
    
    NSString *key = item.imageKey;
    
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
    
}
@end
