//
//  ViewController.h
//  HelloPolly
//
//  Created by CSI Student on 04/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;
@property (strong, nonatomic) IBOutlet PolygonShape *model;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;

@property (strong, nonatomic) IBOutlet UILabel *shapeLabel;


@property (strong, nonatomic) IBOutlet PolygonView *polygon;




-(IBAction)increase:(UIButton *)sender;
-(IBAction)decrease:(UIButton *)sender;
-(IBAction)change:(UIStepper *)sender;


@end
