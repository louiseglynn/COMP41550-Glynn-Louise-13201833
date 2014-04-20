//
//  Document.h
//  TahDoodle
//
//  Created by CSI Student on 30/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument <NSTableViewDataSource>

@property (nonatomic) NSMutableArray *tasks;
@property (nonatomic) IBOutlet NSTableView *taskTable;

-(IBAction)addTask:(id)sender;
-(IBAction)deleteTask:(id)sender;

@end
