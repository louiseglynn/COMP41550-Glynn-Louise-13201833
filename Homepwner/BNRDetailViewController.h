//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by CSI Student on 17/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

@property (nonatomic, strong) BNRItem *item;


-(instancetype)initForNewItem:(BOOL)isNew;

@end
