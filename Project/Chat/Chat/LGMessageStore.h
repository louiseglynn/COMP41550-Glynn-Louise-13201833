

#import <Foundation/Foundation.h>




@class Message;


@interface LGMessageStore : NSObject

@property (nonatomic, readonly) NSArray *allMessages;

+(instancetype)sharedStore;

-(Message *)createMessage;
//-(void)removeMessage:(Message *)message;

-(BOOL)saveChanges;

@end
