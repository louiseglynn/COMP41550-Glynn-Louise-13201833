//
//  AppDelegate.h
//  iTahDoodle
//
//  Created by CSI Student on 30/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *BNRDocPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) UITableView *taskTable;
@property (nonatomic) UITextField *taskField;
@property (nonatomic) UIButton *insertButton;

@property (nonatomic) NSMutableArray *tasks;

-(void) addTask:(id)sender;

@end
