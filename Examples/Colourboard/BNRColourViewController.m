//
//  BNRColourViewController.m
//  Colourboard
//
//  Created by CSI Student on 20/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRColourViewController.h"

@interface BNRColourViewController()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end


@implementation BNRColourViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIColor *color = self.colourDescription.colour;
    
    float red, green, blue;
    
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    
    
    self.view.backgroundColor = color;
    
    self.textField.text = self.colourDescription.name;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(self.existingColour){
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.colourDescription.name = self.textField.text;
    
    self.colourDescription.colour = self.view.backgroundColor;
    
}

-(IBAction)changeColor:(id)sender{
    
    float red = self.redSlider.value;
    
    float green = self.greenSlider.value;
    
    float blue = self.blueSlider.value;
    
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.view.backgroundColor = newColor;
}



-(IBAction)dismiss:(id)sender{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
