//
//  ViewController.h
//  HelloPolly
//
//  Created by CSI Student on 09/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"


@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet PolygonShape *model;

@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;

@property (nonatomic)  NSArray *points;

- (IBAction)decrease:(id)sender;

- (IBAction)increase:(id)sender;

@end




