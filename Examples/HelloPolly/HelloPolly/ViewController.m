//
//  ViewController.m
//  HelloPolly
//
//  Created by CSI Student on 09/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <PolygonViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.polygonView.delegate] = self;
    
}

- (NSArray *)pointsInRect
{
    self.polygonShapeModel.pointsInRect;
}

- (void)dealloc
{
    // Do any additional setup after loading the view, typically from a nib.
    self.numberOfSidesLabel = nil;
    self.model = nil;
    //[super dealloc];
    
    self.model.numberOfSides = [self.numberOfSidesLabel.text integerValue];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (IBAction)decrease:(UIButton *)sender {
    NSLog(@"Decrease");
    self.model.numberOfSides--;
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d" , self.model.numberOfSides];
    NSLog(@"My Polygon %@", self.model.name);
    
}

- (IBAction)increase:(UIButton *)sender {
    NSLog(@"Increase");
    self.model.numberOfSides++;
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d" , self.model.numberOfSides];
    NSLog(@"My Polygon %@", self.model.name);
   
}





@end
