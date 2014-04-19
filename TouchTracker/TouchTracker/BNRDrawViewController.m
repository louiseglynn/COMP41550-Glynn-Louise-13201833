//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by CSI Student on 18/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

-(void)loadView{
    self.view = [[BNRDrawView alloc]initWithFrame:CGRectZero];
}


@end
