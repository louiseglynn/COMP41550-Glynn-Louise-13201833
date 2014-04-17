//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController()

//@property (nonatomic, strong) IBOutlet UIView *headerView;

@end


@implementation BNRItemsViewController

/*-(UIView *)headerView
{
    if(!_headerView){
        
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
        
    }
    return _headerView;
}
*/

-(IBAction)addNewItem:(id)sender
{
    BNRItem *item = [[BNRItem alloc]initWithName:@"Test" andNumber:@"1234567"];
    
   [[BNRItemStore sharedStore]createItem:item];
    
    NSInteger lastRow = [[[BNRItemStore sharedStore]allItems]indexOfObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

/*
-(IBAction)toggleEditingMode:(id)sender
{
    if(self.isEditing)
    {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    else
    {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}*/

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    /*UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];*/
}

-(instancetype)init{
    
    self = [super initWithStyle:UITableViewStylePlain];
    
    if(self){
        
        UINavigationItem *navItem = self.navigationItem;
        
        navItem.title = @"Contacts";
        
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        
        BNRItem *item1 = [[BNRItem alloc]initWithName:@"Louise" andNumber:@"0857550453"];
        BNRItem *item2 = [[BNRItem alloc]initWithName:@"Joe" andNumber:@"0851234567"];
        
        [[BNRItemStore sharedStore]createItem:item1];
        
        [[BNRItemStore sharedStore]createItem:item2];
        
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    
    
    return [self init];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [[[BNRItemStore sharedStore]allItems]count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = item.name;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        NSArray *items = [[BNRItemStore sharedStore]allItems];
        
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore]removeItem:item];
        
        [tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
         
    }
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BNRDetailViewController *dvc = [[BNRDetailViewController alloc]init];
    
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    BNRItem *item = items[indexPath.row];
    
    dvc.item = item;
    
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

@end
