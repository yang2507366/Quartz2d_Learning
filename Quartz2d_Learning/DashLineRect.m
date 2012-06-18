//
//  DashLineRect.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DashLineRect.h"

@implementation DashLineRect

- (void)createPathInContext:(CGContextRef)context rect:(CGRect)rect
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
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect ourRect = CGRectMake(20, 40, 100, 100);
    
    float lengths[4] = {4.0f, 2.0f, 3.0f, 10.0f};// 该数组第一个元素为线条可见长度，第二个为线条隐藏长度，以此类推
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    CGContextSetLineDash(context, 
                         0, // the location to begin the dash pattern，一般设为0
                         lengths, 
                         2);// 模式使用长度，应在lengths数组长度范围之内
    [self createPathInContext:context rect:ourRect];
    CGContextDrawPath(context, kCGPathStroke);
}

@end
