//
//  ViewController.m
//  HelloPolly
//
//  Created by CSI Student on 04/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.stepper.maximumValue = 12;
    self.stepper.minimumValue = 3;
    
    [self updateView];
    
    
}

-(void)updateView
{
    NSString *shapeText = [NSString stringWithFormat:@"%@", self.model.name];
    NSString *text = [NSString stringWithFormat:@"%d", self.model.numberOfSides];
    
    [self.shapeLabel setText:shapeText];
    [self.shapeLabel sizeToFit];
    [self.numberOfSidesLabel setText:text];
    [self.numberOfSidesLabel sizeToFit];
    self.stepper.value = self.model.numberOfSides;
    self.polygon.numberOfSides = self.model.numberOfSides;
    
    //NSLog(@"@%@", self.model);
    //NSLog(@"@%@", self.view);
    //NSLog(@"@%@", self.polygon);
    
    
    [self.polygon setNeedsDisplay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNumberOfSidesLabel:nil];
    [self setModel:nil];
    [super viewDidUnload];
}

-(IBAction)increase:(UIButton *)sender{
    
    [self increase];
}

-(void)increase{
    if(self.model.numberOfSides < 12){
        self.increaseButton.enabled = YES;
        self.decreaseButton.enabled = YES;
        self.model.numberOfSides++;
        if(self.model.numberOfSides == 12){
            self.increaseButton.enabled = NO;
        }
        NSLog(@"increase");
    }
    
    [self updateView];
}

-(IBAction)decrease:(UIButton *)sender{
    [self decrease];
    
}

-(void)decrease{
    if(self.model.numberOfSides > 3){
        self.increaseButton.enabled = YES;
        self.decreaseButton.enabled = YES;
        self.model.numberOfSides--;
        if(self.model.numberOfSides == 3){
            self.decreaseButton.enabled = NO;
        }
        NSLog(@"decrease");
    }
    
    [self updateView];
}

-(IBAction)change:(UIStepper *)sender{
    
    if(sender.value > self.model.numberOfSides){
        [self increase];
    }
    else{
        [self decrease];
    }
    
    NSLog(@"%f", sender.value);
}

@end
