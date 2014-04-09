//
//  ViewController.h
//  HelloPolly
//
//  Created by CSI Student on 09/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *shape;

@property (strong, nonatomic) IBOutlet UILabel *sides;

@property (strong, nonatomic) IBOutlet PolygonShape *model;

@property (strong, nonatomic) IBOutlet PolygonView *pv;

@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UIButton *decreaseButton;
@property (strong, nonatomic) IBOutlet UIButton *increaseButton;

- (IBAction)decrease:(UIButton *)sender;
- (IBAction)increase:(UIButton *)sender;
- (IBAction)stepperButton:(UIStepper *)sender;

@end
