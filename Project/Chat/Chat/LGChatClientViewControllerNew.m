//
//  LGChatClientViewController.m
//  Chat
//
//  Created by CSI Student on 21/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "LGChatClientViewControllerNew.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
@import CoreData;
#import "Message.h"


@interface LGChatClientViewControllerNew ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end

@implementation LGChatClientViewControllerNew

NSMutableArray *bubbleData;

-(NSString *)itemArchivePath{
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"message.data"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
    
    NSString *path = self.itemArchivePath;
    
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    
    if(![psc addPersistentStoreWithType:NSSQLiteStoreType
                          configuration:nil
                                    URL:storeURL
                                 options:nil
                                   error:&error]){
        @throw [NSException exceptionWithName:@"OpenFailure"
                                       reason:[error localizedDescription]
                                     userInfo:nil];
    }
    
    _context = [[NSManagedObjectContext alloc]init];
    _context.persistentStoreCoordinator = psc;
    
    [self loadAllItems];
    
    //[self getNewMessages];
    
    _messageText.delegate = self;
    
    _bubbleTable.bubbleDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    _bubbleTable.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    _bubbleTable.showAvatars = YES;
    
    // Uncomment the line below to add "Now typing" bubble
    // Possible values are
    //    - NSBubbleTypingTypeSomebody - shows "now typing" bubble on the left
    //    - NSBubbleTypingTypeMe - shows "now typing" bubble on the right
    //    - NSBubbleTypingTypeNone - no "now typing" bubble
    
    _bubbleTable.typingBubble = NSBubbleTypingTypeSomebody;
    
    
    //[self.bubbleTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tblBubbleCell"];

    
    
    // Keyboard events
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(BOOL)saveChanged{
    
    NSError *error;
    BOOL successful = [self.context save:&error];
    
    if(!successful){
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
    
}

-(void)loadAllItems{
    
    if(!messages){
        
        NSLog(@"load messages");
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:self.context];
        
        request.entity = e;
        
        NSError *error;
        
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        
        if(!result){
            [NSException raise:@"Fetch failed"
                        format:@"Reason %@", [error localizedDescription]];
            
        }
        messages = [[NSMutableArray alloc]initWithArray:result];
        
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

#pragma mark - Keyboard events

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = self.textInputView.frame;
        frame.origin.y -= kbSize.height;
        self.textInputView.frame = frame;
        
        frame = self.bubbleTable.frame;
        frame.size.height -= kbSize.height;
        self.bubbleTable.frame = frame;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = self.textInputView.frame;
        frame.origin.y += kbSize.height;
        self.textInputView.frame = frame;
        
        frame = self.bubbleTable.frame;
        frame.size.height += kbSize.height;
        self.bubbleTable.frame = frame;
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_messageText resignFirstResponder];
    return YES;
}




#pragma mark - Actions

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)sendClicked:(id)sender
{
    self.bubbleTable.typingBubble = NSBubbleTypingTypeNobody;
    
    NSBubbleData *sayBubble = [NSBubbleData dataWithText:self.messageText.text date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeMine];
    [bubbleData addObject:sayBubble];

    
    if([_messageText.text length] >0){
        
        Message *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:self.context];
        
        [messages addObject:message]; 
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        NSURL *url = [[NSURL alloc]initWithString:@"http://louiseglynn.com/chat/addMessage.php"];
        
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"user=%@&message=%@",username,
                           _messageText.text] dataUsingEncoding:NSUTF8StringEncoding] ];
        
        [request setHTTPBody:body];
        
        [NSURLConnection connectionWithRequest:request delegate:self];
        
        [self getNewMessages];
    }
    
    //[self.bubbleTable reloadData];
    self.messageText.text = @"";
    [self.messageText resignFirstResponder];

}



-(void)setUsername:(NSString *)uname{
    
    username = uname;
    
}

-(void)getNewMessages{
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://louiseglynn.com/chat/messages.php"];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)timerCallback{
    
    [self getNewMessages];
};

#pragma mark - NSXML Parser specific

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"message"] ) {

        msgAdded = [attributeDict objectForKey:@"added"];
        msgId = [[attributeDict objectForKey:@"id"] intValue];
        msgUser = [[NSMutableString alloc] init];
        msgText = [[NSMutableString alloc] init];
        inUser = NO;
        inText = NO;
    }
    if ( [elementName isEqualToString:@"user"] ) {
        inUser = YES;
    }
    if ( [elementName isEqualToString:@"text"] ) {
        inText = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ( inUser ) {
        [msgUser appendString:string];
    }
    if ( inText ) {
        [msgText appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ( [elementName isEqualToString:@"message"] ) {
        [messages addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgAdded,
                             @"added",msgUser,@"user",msgText,@"text",nil]];
        
        lastId = msgId;

    }
    if ( [elementName isEqualToString:@"user"] ) {
        inUser = NO;
    }
    if ( [elementName isEqualToString:@"text"] ) {
        inText = NO;
    }
}


#pragma mark - URL connection defaults

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    [self performSegueWithIdentifier:@"loginConError" sender:self];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    receivedData = [NSMutableData data];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    
    [receivedData appendData:data];
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    
    return nil;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    messages = [[NSMutableArray alloc]init];
    
    
    chatParser = [[NSXMLParser alloc]initWithData:receivedData];
    
    
    [chatParser setDelegate:self];
    [chatParser parse];

    
    bubbleData = [[NSMutableArray alloc]init];
    
    for(NSDictionary *d in messages){
        
        
        NSString *str = [d objectForKey:@"text"];
        
        NSString *user = [d objectForKey:@"user"];
        
        NSString *added = [d objectForKey:@"added"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-M-d HH:mm:ss"];
        
        NSDate *date =  [dateFormat dateFromString:added];

        
        NSBubbleData *bubble;
        
        if([user isEqualToString:@"counsellor"]){
            
            bubble = [NSBubbleData dataWithText:str date:date type:BubbleTypeSomeoneElse];
            bubble.avatar = [UIImage imageNamed:@"avatar-1.jpg"];
        }
        else
        {

            bubble = [NSBubbleData dataWithText:str date:date type:BubbleTypeMine];
            bubble.avatar = nil;
        }

        
        [bubbleData addObject:bubble];
        
    }
    
    [_bubbleTable reloadData];
    
    
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(timerCallback)]];
    
    [invocation setTarget:self];
    
    [invocation setSelector:@selector(timerCallback)];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 invocation:invocation repeats:NO];
    
}








@end
