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



- (void)drawRect:(CGRect)rect
{
     NSLog(@"rect called");
    
    [self.delegate numberOfSides:self];
    
    //if(self.numberOfSides > 2){
        
        NSLog(@"no of sides ok");
        
        self.points = [self pointsForPolygonInRect:rect numberOfSides:3];
    
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
            
            NSLog(@"test");
           
            CGContextAddLineToPoint(context, point.x, point.y);
             
        }
        
        CGContextDrawPath(context, kCGPathFillStroke);
    //}
}


@end
