//
//  PolygonView.m
//  HelloPolly
//
//  Created by CSI Student on 04/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "PolygonView.h"


@implementation PolygonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    //NSLog(@"being called automatically");
    
    self.points = [self pointsForPolygonInRect:rect numberOfSides:self.numberOfSides];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); //C
    //[[UIColor redColor] setStroke]; //ObC
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0); //C
    //[[UIColor greenColor] setFill]; //ObC
    
    
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGPoint point = [self.points[0] CGPointValue];
    
    CGContextMoveToPoint(context, point.x, point.y);
    
    
    for(int idx = 0; idx < self.points.count; idx++)
    {
        CGPoint point = [self.points[idx] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

-(NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides {
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:
                           CGPointMake(center.x+curX,center.y+curY)]];
    }
    return result;
}

@end
