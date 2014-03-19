//
//  ViewController.h
//  OrientationBasics
//
//  Created by CSI Student on 27/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

IBOutlet UIView *mainPortraitView;
IBOutlet UIView *mainLandscapeView;

UIDeviceOrientation orientation;

@end

@property (nonatomic, retain) UIView *mainPortraitView;
@property (nonatomic, retain) UIView *mainLandscapeView;

(void)clearCurrentView;


