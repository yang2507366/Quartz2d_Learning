//
//  SimpleRect.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SimpleRect.h"

@implementation SimpleRect

- (void)drawRect:(CGRect)rect
{
    /**
        注意事项：
        view必须有足够大的frame，否则绘制不会显示出来
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, rect);
    
    CGRect newRect = CGRectMake(0, 0, 50, 50);
    // fill
    CGContextSetRGBFillColor(context, 1.0, 0.0, 1.0, 1.0);
    CGContextFillRect(context, newRect);
    
    // stoke
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextStrokeRect(context, newRect);
}

@end
