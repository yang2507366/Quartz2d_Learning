//
//  Transform_01.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Transform_01.h"

@implementation Transform_01

- (void)createRectPathWithContext:(CGContextRef)context rect:(CGRect)rect
{
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
    
    CGContextClosePath(context);
}

- (void)drawRect:(CGRect)rect
{
    CGRect ourRect = {{20.0f, 220.0f}, {130.0f, 100.0f}};
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self createRectPathWithContext:context rect:ourRect];
    CGContextSetRGBFillColor(context, 0.482, 0.62, 0.871, 1.0);
    CGContextDrawPath(context, kCGPathFill);
    
    // rect2 translate transform
    CGContextTranslateCTM(context, 200.0, 0);
    CGContextSetRGBStrokeColor(context, 0.404, 0.808, 0.239, 1.0);
    [self createRectPathWithContext:context rect:ourRect];
    CGContextSetLineWidth(context, 10.0f);
    CGContextDrawPath(context, kCGPathStroke);
    
    // rect3 translate transform
    CGContextTranslateCTM(context, -100.0f, -200.0f);
    [self createRectPathWithContext:context rect:ourRect];
    CGContextDrawPath(context, kCGPathFill);
}

@end
