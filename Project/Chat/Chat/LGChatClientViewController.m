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

int bubbleFragment_width, bubbleFragment_height;
int bubble_x, bubble_y;
static CGFloat const FONTSIZE = 14.0;
static int const DATELABEL_TAG = 1;
static int const MESSAGELABEL_TAG = 2;
static int const IMAGEVIEW_TAG_1 = 3;

#pragma mark - default methods

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     NSLog(@"hello louise");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        lastId = 0;
        chatParser = NULL;
        
       
    }
    return self;
}*/

//---calculate the height for the message---
-(CGFloat) labelHeight:(NSString *) text {
    CGSize maximumLabelSize = CGSizeMake((bubbleFragment_width * 3) - 25,9999);
    CGSize expectedLabelSize = [text sizeWithFont:[UIFont systemFontOfSize: FONTSIZE]
                                constrainedToSize:maximumLabelSize
                                    lineBreakMode:UILineBreakModeWordWrap];
    return expectedLabelSize.height;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //---add this---
    //---location to display the bubble fragment---
    bubble_x = 10;
    bubble_y = 20;
    
    //---size of the bubble fragment---
    bubbleFragment_width = 56;
    bubbleFragment_height = 32;
	
    
    _messageList.dataSource = self;
    _messageList.delegate = self;
    
    
    [self getNewMessages];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ChatListItem"];

    
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
    /*
    
    
    int labelHeight = [self labelHeight:[messages objectAtIndex:indexPath.row]];
    labelHeight -= bubbleFragment_height;
    if (labelHeight<0) labelHeight = 0;
    
    return (bubble_y + bubbleFragment_height * 2 + labelHeight) + 5;
     */
    
    return 75;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    UITableViewCell *cell = (UITableViewCell *)[self.messageList dequeueReusableCellWithIdentifier:@"ChatListItem"];
    
    
    /*
    UILabel* dateLabel = nil;
    UILabel* messageLabel = nil;
    UIImageView *imageView = nil;
    
    //--------------
    
    //---add this---
    //---date---
    dateLabel = [[UILabel alloc] init];
    dateLabel.tag = DATELABEL_TAG;
    [cell.contentView addSubview: dateLabel];
    
    //---message--
    messageLabel = [[UILabel alloc] init];
    messageLabel.tag = MESSAGELABEL_TAG;
    [cell.contentView addSubview: messageLabel];
    
    //---set the images to display for each UIImageView---
    imageView.image =
    [UIImage imageNamed:@"iphone-sms-2.jpg"];
    
    //---calculate the height for the label---
    int labelHeight = [self labelHeight:[messages objectAtIndex:indexPath.row]];
    labelHeight -= bubbleFragment_height;
    if (labelHeight<0) labelHeight = 0;
    
    //---you can customize the look and feel for the date for each message here---
    dateLabel.frame = CGRectMake(0.0, 0.0, 200, 15.0);
    dateLabel.font = [UIFont boldSystemFontOfSize: FONTSIZE];
    dateLabel.textAlignment = UITextAlignmentLeft;
    dateLabel.textColor = [UIColor darkGrayColor];
    dateLabel.backgroundColor = [UIColor clearColor];
    
    //---top left---
    imageView.frame =
    CGRectMake(bubble_x, bubble_y, bubbleFragment_width, bubbleFragment_height);
    
    
    //---you can customize the look and feel for each message here---
    messageLabel.frame =
    CGRectMake(bubble_x + 10, bubble_y + 5,
               (bubbleFragment_width * 3) - 25,
               (bubbleFragment_height * 2) + labelHeight - 10);
    
    messageLabel.font = [UIFont systemFontOfSize:FONTSIZE];
    messageLabel.textAlignment = UITextAlignmentCenter;
    messageLabel.textColor = [UIColor darkTextColor];
    messageLabel.numberOfLines = 0; //---display multiple lines---
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    //dateLabel.text = [dateOfMessages objectAtIndex:indexPath.row];
    */
    
    NSDictionary *itemAtIndex = (NSDictionary *)[messages objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [itemAtIndex objectForKey:@"text"];
    
    cell.detailTextLabel.text = [itemAtIndex objectForKey:@"user"];
    
    //messageLabel.text = [messages objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void)setUsername:(NSString *)uname{
    
    username = uname;
    
}

@end
