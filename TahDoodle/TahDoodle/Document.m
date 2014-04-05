//
//  Document.m
//  TahDoodle
//
//  Created by CSI Student on 30/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "Document.h"

@implementation Document

#pragma mark - NSDocument Overrides

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}



#pragma mark - Actions

-(void)addTask:(id)sender
{
    NSLog(@"Add Task");
    if(!self.tasks){
        self.tasks = [NSMutableArray array];
    }
    
    [self.tasks addObject:@"New Item"];
    [self.taskTable reloadData];
    [self updateChangeCount:NSChangeDone];
    
}

-(void)deleteTask:(id)sender
{
    if(self.taskTable.selectedRow != -1){
         NSLog(@"Delete Task: %ld", (long)self.taskTable.selectedRow);
        [self.tasks removeObjectAtIndex:self.taskTable.selectedRow];
        [self.taskTable reloadData];
        [self updateChangeCount:NSChangeDone];

    }

}



#pragma mark - Data Source Methods
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.tasks count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self.tasks objectAtIndex:row];
}

-(void)tableView:(NSTableView *)tableVIew setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    [self.tasks replaceObjectAtIndex:row withObject:object];
    [self updateChangeCount:NSChangeDone];
}




-(NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError{
    if(!self.tasks){
        self.tasks = [NSMutableArray array];
    }
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:self.tasks format:NSPropertyListXMLFormat_v1_0 options:0 error:outError];
    
    return data;
    
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    self.tasks = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:outError];
    
    return (self.tasks != nil);
}


@end
