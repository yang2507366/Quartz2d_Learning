//
//  DrawImgTest.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawImgTest.h"

@implementation DrawImgTest

- (UIImage *)clipImage:(UIImage *)img clipRect:(CGRect)clipRect
{
    CGFloat imgWidth = clipRect.size.width * img.scale;
    CGFloat imgHeight = clipRect.size.height * img.scale;
    if(imgWidth == 0 || imgHeight == 0){
        return nil;
    }
    
    CGRect tmpRect = clipRect;
    tmpRect.origin.y = img.size.height - (tmpRect.origin.y + tmpRect.size.height);
    clipRect = tmpRect;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, 
                                                 imgWidth, 
                                                 imgHeight, 
                                                 8, 
                                                 4 * imgWidth, 
                                                 colorSpace, 
                                                 kCGImageAlphaPremultipliedFirst);
    CGContextBeginPath(context);
    CGContextAddRect(context, CGRectMake(0, 0, clipRect.size.width * img.scale, clipRect.size.height * img.scale));
    CGContextClip(context);
    
    CGContextDrawImage(context, 
                       CGRectMake(-clipRect.origin.x * img.scale, 
                                  -clipRect.origin.y * img.scale, 
                                  img.size.width * img.scale, 
                                  img.size.height * img.scale), 
                       img.CGImage);
    
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *resultImg = [UIImage imageWithCGImage:imgRef scale:img.scale orientation:UIImageOrientationUp];
    CGImageRelease(imgRef);
    
    return resultImg;
}

- (UIImage *)strechImage:(UIImage *)img clipRect:(CGRect)clipRect toWidth:(CGFloat)width
{
    return nil;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextFillRect(context, rect);
    
//    CGContextBeginPath(context);
//    CGContextAddRect(context, CGRectMake(0, 20, 5, 10));
//    CGContextClip(context);
    
    UIImage *img = [UIImage imageNamed:@"topbar-pop-bg.png"];
    UIImage *clipImg = [self clipImage:img clipRect:CGRectMake(0, 0, 10, 20)];
    [img drawAtPoint:CGPointMake(0, 0)];
    [clipImg drawAtPoint:CGPointMake(0, 100)];
}

@end
