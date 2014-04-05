//
//  ViewController.m
//  Quiz
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
    
    questions = [[NSMutableArray alloc]init];
    answers = [[NSMutableArray alloc]init];
    
    [questions addObject:@"What is 7+7"];
    [answers addObject:@"14"];
    
    [questions addObject:@"What is 8+8"];
    [answers addObject:@"16"];

    [questions addObject:@"What is 9+9"];
    [answers addObject:@"18"];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showQuestion:(id)sender{
    
    currentQuestionIndex++;
    
    if(currentQuestionIndex== [questions count]){
        currentQuestionIndex = 0;
    }
    
    NSString *question = [questions objectAtIndex:currentQuestionIndex];
    
    [questionField setText:question];
    
    [answerField setText:@"????"];
    
    //NSLog(@"Show Question");
    //[questionField setText:@"test question"];
    
}
-(IBAction)showAnswer:(id)sender{
    
    NSString *answer = [answers objectAtIndex:currentQuestionIndex];
    //NSLog(@"Show Answer");
    [answerField setText:answer];
    
}

@end
