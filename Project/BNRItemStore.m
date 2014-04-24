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

@import CoreData;



@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;


@end

@implementation BNRItemStore

-(instancetype)initPrivate{
    
    
    
    self = [super init];
    
    if(self){
        
        //_privateItems = [[NSMutableArray alloc]init];
        
        //NSString *path = [self itemArchivePath];
        ///_privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        //if(!_privateItems){
          //  _privateItems = [[NSMutableArray alloc]init];
        //}
        
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        
        NSString *path = self.itemArchivePath;
        
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
            
            @throw [NSException exceptionWithName:@"open failure" reason:[error localizedDescription] userInfo:nil];
        }
        
        _context = [[NSManagedObjectContext alloc]init];
        
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
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

-(BNRItem *)createItem{
    
    double order;
    
    if([self.allItems count] ==0){
        order = 1.0;
    }
    else{
        order = [[self.privateItems lastObject]orderingValue]+1.0;
    }
    
    BNRItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem" inManagedObjectContext:self.context];
    
    item.orderingValue = order;
  
    [self.privateItems addObject:item];
    
    return item;
   
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
    
    [self.context deleteObject:item];
    
    [self.privateItems removeObjectIdenticalTo:item];
    
}

-(NSString *)itemArchivePath{
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    //return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
    
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
    
}

-(BOOL)saveChanges{
    //NSString *path = [self itemArchivePath];
    
    //return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
    
    
    NSError *error;
    
    BOOL successful = [self.context save:&error];
    
    if(!successful){
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

-(void)loadAllItems{
    
    if(!self.privateItems){
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"BNRItem" inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        
        request.sortDescriptors = @[sd];
        
        NSError *error;
        
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        
        if(!result){
            
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
             
            
        }
        self.privateItems = [[NSMutableArray alloc]initWithArray:result];
    }
    
    
}


@end
