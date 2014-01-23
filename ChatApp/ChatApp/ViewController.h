//
//  ViewController.h
//  ChatApp
//
//  Created by CSI Student on 10/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) IBOutlet UITextView *textEntry;
@end
