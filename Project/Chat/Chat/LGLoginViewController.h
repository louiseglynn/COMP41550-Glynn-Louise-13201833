//
//  LGLoginViewController.h
//  Chat
//
//  Created by CSI Student on 21/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGLoginViewController : UIViewController<UITextFieldDelegate>{

NSMutableData *receivedData;

    
}

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

- (IBAction)loginClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *errorMessage;

@end
