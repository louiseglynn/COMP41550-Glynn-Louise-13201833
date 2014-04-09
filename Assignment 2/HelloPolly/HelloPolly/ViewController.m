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
    
    self.pv.points = [self.model pointsForPolygonInRect:self.pv.frame numberOfSides:self.model.numberOfSides];
    


}

- (void)viewDidUnload {
    //[self setNumberOfSidesLabel:nil];
    //[self setModel:nil];
    
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

- (IBAction)decrease:(id)sender {
}

- (IBAction)increase:(id)sender {
}
@end
