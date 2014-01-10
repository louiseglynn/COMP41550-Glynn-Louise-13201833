//
//  PolygonView.h
//  HelloPolly
//
//  Created by CSI Student on 09/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"

@interface PolygonView : UIView

@property (assign, nonatomic) int numberOfSides;
@property (weak, nonatomic) IBOutlet PolygonShape *model;
@property (nonatomic)  NSArray *points;

@end



