//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by CSI Student on 17/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"


@interface BNRDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;

@end

@implementation BNRDetailViewController



-(void)setItem:(BNRItem *)item{
    
    _item = item;
    self.navigationItem.title = _item.name;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.name;
    self.numberField.text = item.number;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    
    item.name = self.nameField.text;
    item.number = self.numberField.text;
    
}




@end
