//
//  PolygonView.m
//  HelloPolly
//
//  Created by CSI Student on 09/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "PolygonView.h"


@interface PolygonView () <UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *polygonView;
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end

@implementation PolygonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (UIDynamicAnimator *)animator
{
    if (!_animator)
    {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.polygonView];
        _animator.delegate = self;
    }
    return _animator;
}


- (void)drawPolygon
{
    CGRect frame;
    
//pointsForPolygonInRect:numberOfSides:
    
    //frame.origin = CGPointZero;
    //frame.size;
    //int x = (arc4random() % (int)self.gameView.bounds.size.width) ;
    //frame.origin.x = x;
    
    //UIView *polygon = [[UIView alloc] initWithFrame:frame];
    //polygon.backgroundColor;
    
    //[self.polygonView addSubview:polygon];

}

- (void)drawRect:(CGRect)rect
{
    self.points = [self pointsForPolygonInRect:rect numberOfSides:3];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    for(int idx = 0; idx < self.points.count; idx++)
    {
        
        //NSLog(@self.points)
        
        //CGPointMake point = [self.points objectAtIndex:idx];//Edited
        //if(idx == 0)
        //{
        // move to the first point
        //  CGContextMoveToPoint(context, point.x, point.y);
        //}
        //else
        //{
        //  CGContextAddLineToPoint(context, point.x, point.y);
    }
}


- (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides {
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x; NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x+curX,center.y+curY)]];
    }
    return result;
}


@end
