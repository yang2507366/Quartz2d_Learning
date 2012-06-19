//
//  ClippingDrawing.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClippingDrawing.h"

@implementation ClippingDrawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextFillRect(context, rect);
    
    CGPoint circleCenter = {150.0f, 150.0f};
    float circleRadius = 100.0f;
    float startAngle = 0.0f;
    float endAngle = 2 * M_PI;
    
    CGRect ourRect = {{65.0f, 65.0f}, {170.0f, 170.0f}};
    
    // fill circle
    CGContextSetRGBFillColor(context, 0.663, 0., 0.031, 1.0);
    CGContextBeginPath(context);
    CGContextAddArc(context, circleCenter.x, circleCenter.y, circleRadius, startAngle, endAngle, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    // stoke rect
    CGContextStrokeRect(context, ourRect);
    
    // translate 
    ourRect.size.width = 150.0f;
    ourRect.size.height = 150.0f;
    
    CGContextTranslateCTM(context, ourRect.size.width + circleRadius + 5.0f, 0.0f);
//    CGContextScaleCTM(context, 0.70, 0.70);
    CGContextBeginPath(context);
    CGContextAddRect(context, ourRect);
    CGContextClip(context); // 指定一块区域，之后绘制的图像都不会超出这个区域
    
    CGContextBeginPath(context);
    CGContextAddArc(context, circleCenter.x, circleCenter.y, circleRadius, startAngle, endAngle, 0);
    CGContextDrawPath(context, kCGPathFill);
    
}

@end
