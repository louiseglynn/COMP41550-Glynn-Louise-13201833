//
//  LGChatClientViewController.m
//  Chat
//
//  Created by CSI Student on 21/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "LGChatClientViewController.h"

@interface LGChatClientViewController ()

@end

@implementation LGChatClientViewController

#pragma mark - default methods


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _messageList.dataSource = self;
    _messageList.delegate = self;
    
    
    [self getNewMessages];
    
    NSLog(@"%@", messages);
    
    [self.messageList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ChatListItem"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - application specific

- (IBAction)sendClicked:(id)sender {
    
    [_messageText resignFirstResponder];
    
    if([_messageText.text length] >0){
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        
        NSURL *url = [[NSURL alloc]initWithString:@"http://louiseglynn.com/chat/addMessage.php"];
        
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"user=%@&message=%@",username,
                          _messageText.text] dataUsingEncoding:NSUTF8StringEncoding] ];
        
        [request setHTTPBody:body];
        
        NSHTTPURLResponse *response = nil;
        
        NSError *error = [[NSError alloc]init];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        [self getNewMessages];
    }
    
}

-(void)getNewMessages{
    

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://louiseglynn.com/chat/messages.php"];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(conn){
        
        
        receivedData = [NSMutableData data];
        
        
    }
    else{
        
    }
}

-(void)timerCallback{
    
    [self getNewMessages];
};

#pragma mark - NSXML Parser specific

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    
    
    if([elementName isEqualToString:@"message"]){
        
        msgAdded = [attributeDict objectForKey:@"added"];
        msgId = [[attributeDict objectForKey:@"id"]intValue];
        msgUser =  [[NSMutableString alloc]init];
        msgText = [[NSMutableString alloc]init];
        
        inUser = NO;
        inText = NO;
        
    }
    
    if([elementName isEqualToString:@"user"]){
        
        inUser = YES;
    }
    
    if([elementName isEqualToString:@"text"]){
        inText = YES;
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if(inUser){
        [msgUser appendString:string];
    }
    
    if(inText) {
        [msgText appendString:string];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"message"]){
        
        [messages addObject:[NSDictionary dictionaryWithObjectsAndKeys:msgAdded, @"added", msgUser, @"user", msgText, @"text", nil]];
        
        lastId = msgId;
        
        if([elementName isEqualToString:@"user"]){
            inUser = NO;
        }
        
        if([elementName isEqualToString:@"text"]){
            inText = NO;
        }
        
        
    }
    
}


#pragma mark - URL connection defaults

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [receivedData setLength:0];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receivedData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
  
    messages = [[NSMutableArray alloc]init];
        
    
    chatParser = [[NSXMLParser alloc]initWithData:receivedData];

    
    [chatParser setDelegate:self];
    [chatParser parse];

    NSLog(@"%@", messages);
    
    [_messageList reloadData];
    
  
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(timerCallback)]];
    
    [invocation setTarget:self];
    
    [invocation setSelector:@selector(timerCallback)];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 invocation:invocation repeats:NO];
    
}


#pragma mark - table view specific

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return (messages == nil)? 0: [messages count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   //NSLog(@"%@", messages);
    
    
    UITableViewCell *cell = (UITableViewCell *)[self.messageList dequeueReusableCellWithIdentifier:@"ChatListItem"];

    
    
    
    NSDictionary *itemAtIndex = (NSDictionary *)[messages objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [itemAtIndex objectForKey:@"text"];
    cell.detailTextLabel.text = [itemAtIndex objectForKey:@"user"];
    
    
    return cell;
    
}

-(void)setUsername:(NSString *)uname{
    
    username = uname;
    
}

@end
