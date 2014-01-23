//
//  PolygonView.h
//  HelloPolly
//
//  Created by CSI Student on 09/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"

@class PolygonView;

@protocol PolycongViewDelegate <NSObject>

- (NSArray *) pointsInRect:(CGRect)rect;

@end


@interface PolygonView : UIView

@property (weak, nonatomic) IBOutlet id <PolycongViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet PolygonShape *model;
@property (strong, nonatomic)  NSArray *points;

@end



