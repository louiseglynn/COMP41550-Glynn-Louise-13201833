//
//  ViewController.m
//  HelloPolly
//
//  Created by CSI Student on 09/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ViewController.h"
#import "PolygonShape.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSLog(@"Number of sides %d", self.model.numberOfSides);
    
    self.stepper.minimumValue = 3;
    self.stepper.maximumValue = 12;
    

    [self updateView];
    


}

-(void)updateView
{
    NSString *shapeText = [NSString stringWithFormat:@"%@", self.model.name];
    NSString *text = [NSString stringWithFormat:@"%d", self.model.numberOfSides];
    [self.shape sizeToFit];
    [self.shape setText:shapeText];
    [self.sides sizeToFit];
    [self.sides setText:text];
    
    self.stepper.value = self.model.numberOfSides;
    self.pv.points = [self.model pointsForPolygonInRect:self.pv.frame numberOfSides:self.model.numberOfSides];
    
    //NSLog(@"@%@", self.model);
    //NSLog(@"@%@", self.view);
    //NSLog(@"@%@", self.polygon);
    
    
    [self.pv setNeedsDisplay];
    
}


- (void)viewDidUnload {
    //[self setNumberOfSidesLabel:nil];
    //[self setModel:nil];
    //[super viewDidUnload];
    
    self.shape = nil;
    self.sides = nil;
    self.model = nil;
    self.pv = nil;
    
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)decrease:(UIButton *)sender {
    [self decrease];
}

- (IBAction)increase:(UIButton *)sender {
    
    [self increase];

}

- (IBAction)stepperButton:(UIStepper *)sender {
    
    if(sender.value > self.model.numberOfSides){
        [self increase];
    }
    else{
        [self decrease];
    }
    
    NSLog(@"%f", sender.value);
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

@end
