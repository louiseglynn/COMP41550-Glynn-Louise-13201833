//
//  BNRPalleteViewController.m
//  Colourboard
//
//  Created by CSI Student on 20/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRPalleteViewController.h"
#import "BNRColourViewController.h"
#import "BNRColourDescription.h"

@interface BNRPalleteViewController()

@property (nonatomic) NSMutableArray *colours;

@end

@implementation BNRPalleteViewController


-(NSMutableArray *)colours{
    if(!_colours){
        
        _colours = [NSMutableArray array];
        
        BNRColourDescription  *cd = [[BNRColourDescription alloc]init];
        
        [_colours addObject:cd];
        
    }
    return _colours;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.colours count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    BNRColourDescription *colour = self.colours[indexPath.row];
    cell.textLabel.text = colour.name;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"NewColour"]){
        
        BNRColourDescription *colour = [[BNRColourDescription alloc]init];
        
        [self.colours addObject:colour];
        
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        BNRColourViewController *mvc = (BNRColourViewController *)[nc topViewController];
        
        mvc.colourDescription = colour;
        
    }
    else if([segue.identifier isEqualToString:@"ExistingColour"]){
        
        NSIndexPath *ip = [self.tableView indexPathForCell:sender];
        
        BNRColourDescription *colour = self.colours[ip.row];
        
        
        BNRColourViewController *cvc = (BNRColourViewController *)segue.destinationViewController;
        
        cvc.colourDescription = colour;
        cvc.existingColour = YES;
    }
    
}




@end
