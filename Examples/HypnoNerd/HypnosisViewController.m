//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by CSI Student on 11/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "HypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface HypnosisViewController() <UITextFieldDelegate>

@end


@implementation HypnosisViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        self.tabBarItem.title = @"Hypnotise";
        
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        
        self.tabBarItem.image = image;
        
    }
    
    return self;
}

- (void)loadView{
    
    NSLog(@"loading Hypnosis View Controller");
    
    BNRHypnosisView *view = [[BNRHypnosisView alloc]init];
    
    CGRect fieldRect = CGRectMake(40,70, 240, 30);
    
    UITextField *field = [[UITextField alloc]initWithFrame:fieldRect];
    
    field.borderStyle = UITextBorderStyleRoundedRect;
    
    field.text = @"This is a test";
    field.delegate = self;
    
    [view addSubview:field];
    
    self.view = view;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"I have been filled in");
    
    [self addMessageToLabel:textField.text];
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)addMessageToLabel:(NSString *)text{
    
    NSLog(@"Add message function called");
    
    UILabel *label = [[UILabel alloc]init];
    
    //label.backgroundColor = [UIColor clearColor];
    //label.textColor = [UIColor redColor];
    label.text = text;
    
    [label sizeToFit];
    
    CGRect frame = label.frame;
    frame.origin = CGPointMake(100, 100);
    
    label.frame = frame;
    
    
    [self.view addSubview:label];
    
    label.text = text;
    
}

@end
