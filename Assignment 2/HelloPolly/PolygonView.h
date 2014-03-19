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

@protocol PolygonViewDelegate <NSObject>

- (NSArray *) pointsInRect:(CGRect)rect;

@end


@interface PolygonView : UIView

@property (weak, nonatomic) IBOutlet id <PolygonViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet PolygonShape *model;
@property (strong, nonatomic)  NSArray *points;

@end



