//
//  ViewController.h
//  Quiz
//
//  Created by CSI Student on 04/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int currentQuestionIndex;

    NSMutableArray *questions;
    NSMutableArray *answers;

    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}

-(IBAction)showQuestion:(id)sender;
-(IBAction)showAnswer:(id)sender;

@end
