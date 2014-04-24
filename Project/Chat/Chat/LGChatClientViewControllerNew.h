//
//  LGChatClientViewController.h
//  Chat
//
//  Created by CSI Student on 21/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"


@interface LGChatClientViewControllerNew : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate, UIBubbleTableViewDataSource>{

NSMutableData *receivedData;
//NSMutableArray *messages;
NSString *username;

int lastId;


NSTimer *timer;
    
NSXMLParser *chatParser;

NSString *msgAdded;

NSMutableString *msgUser;

NSMutableString *msgText;

int msgId;

Boolean inText;

Boolean inUser;
 


}


@property (weak, nonatomic) IBOutlet UIView *textInputView;

@property (weak, nonatomic) IBOutlet UITextField *messageText;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIBubbleTableView *bubbleTable;

- (IBAction)sendClicked:(id)sender;

-(void)setUsername:(NSString *)username;

@end
