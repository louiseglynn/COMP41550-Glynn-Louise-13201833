//
//  PolygonView.h
//  HelloPolly
//
//  Created by CSI Student on 04/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolygonView : UIView

@property (assign, nonatomic) int numberOfSides;
@property (strong, nonatomic)  NSArray *points;

-(NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides;

@end
