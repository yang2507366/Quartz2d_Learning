//
//  PaintWithAlpha.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PaintWithAlphaAndRotateTransform.h"

@implementation PaintWithAlphaAndRotateTransform

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextFillRect(context, rect);
    
    CGRect ourRect = CGRectMake(0, 0, 130, 100);
    int numOfRects = 6;
    float rotateAngle = 2.0f * M_PI / numOfRects; 
    float tint = 1.0f;
    float tintAdjusts= 1.0f / numOfRects;
    
    CGContextTranslateCTM(context, ourRect.size.width + 30, ourRect.size.height + 100);
    for(int i = 0; i < numOfRects; ++i, tint -= tintAdjusts){
        CGContextSetRGBFillColor(context, tint, 0.0, 0.0, tint);
        CGContextFillRect(context, ourRect);
        CGContextRotateCTM(context, rotateAngle);
    }
}

@end
