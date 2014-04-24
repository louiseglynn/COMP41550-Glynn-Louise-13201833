

#import "LGMessageStore.h"
#import "Message.h"

@import CoreData;



@interface LGMessageStore ()

@property (nonatomic) NSMutableArray *privateMessages;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;


@end

@implementation LGMessageStore

-(instancetype)initPrivate{

    self = [super init];
    
    if(self){

        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        
        NSString *path = self.messageArchivePath;
        
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
            
            @throw [NSException exceptionWithName:@"open failure" reason:[error localizedDescription] userInfo:nil];
        }
        
        _context = [[NSManagedObjectContext alloc]init];
        
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllMessages];
    }
    
    return self;
    
}

+(instancetype)sharedStore{

    static LGMessageStore *sharedStore = nil;
    
    if(!sharedStore){
        
        sharedStore = [[self alloc]initPrivate];
    }
    
    return sharedStore;
}


-(instancetype)init{
    @throw [NSException exceptionWithName:@"singleton" reason:@"Use + [Message sharedStore]" userInfo:nil];
    return nil;
}

-(Message *)createMessage{

    Message *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.context];

  
    [self.privateMessages addObject:message];
    
    return message;
   
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex
               toIndex:(NSUInteger)toIndex{
    
    if(fromIndex == toIndex){
        return;
    }
    
    Message *message = self.privateMessages[fromIndex];
    
    [self.privateMessages removeObjectAtIndex:fromIndex];
    
    [self.privateMessages insertObject:message atIndex:toIndex];
    
    
    
}

-(NSArray *)allMessages{
    
    return self.privateMessages;
}

/*-(void)removeMessage:(Message *)message{
    

    [self.context deleteObject:message];
    
    [self.privateItems removeObjectIdenticalTo:message];
    
}*/

-(NSString *)messageArchivePath{
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
    
}

-(BOOL)saveChanges{

    NSError *error;
    
    BOOL successful = [self.context save:&error];
    
    if(!successful){
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

-(void)loadAllMessages{
    
    if(!self.privateMessages){
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSError *error;
        
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        
        if(!result){
            
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
             
            
        }
        self.privateMessages = [[NSMutableArray alloc]initWithArray:result];
    }
    
    
}


@end
