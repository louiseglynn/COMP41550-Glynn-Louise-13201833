//
//  ViewController.m
//  HelloPolly
//
//  Created by CSI Student on 09/01/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "ViewController.h"

//@interface ViewController ()

//@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)dealloc
{
    // Do any additional setup after loading the view, typically from a nib.
    self.numberOfSidesLabel = nil;
    self.model = nil;
    //[super dealloc];
    
    self.model.numberOfSides = [self.numberOfSidesLabel.text integerValue];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (IBAction)decrease:(UIButton *)sender {
    NSLog(@"Decrease");
    self.model.numberOfSides--;
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d" , self.model.numberOfSides];
    NSLog(@"My Polygon %@", self.model.name);
    
}

- (IBAction)increase:(UIButton *)sender {
    NSLog(@"Increase");
    self.model.numberOfSides++;
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d" , self.model.numberOfSides];
    NSLog(@"My Polygon %@", self.model.name);
   
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
        
        NSLog(@self.points)
        
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
    
    CGContextStrokePath(context);
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
