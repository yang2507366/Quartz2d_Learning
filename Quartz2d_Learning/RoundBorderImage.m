//
//  RoundBorderImage.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-3-22.
//
//

#import "RoundBorderImage.h"

@implementation RoundBorderImage

static void AddRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)

{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM (context, CGRectGetMinX(rect),
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    
    CGContextRestoreGState(context);
}

+ (UIImage *)roundBorderImageWithSize:(CGSize)size cornerSize:(CGFloat)cornerSize strokeColor:(UIColor *)strokeColor stokeSize:(CGFloat)stokeSize
{
    CGFloat paintRoundSize = cornerSize;
    if([UIScreen mainScreen].scale > 1){
        size = CGSizeMake(size.width * 2, size.height * 2);
        paintRoundSize *= 2;
    }
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, [UIScreen mainScreen].scale * stokeSize);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextBeginPath(context);
    AddRoundedRectToPath(context, CGRectMake(0, 0, size.width, size.height * 2), paintRoundSize, paintRoundSize);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    resultImage = [UIImage imageWithCGImage:resultImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    resultImage = [resultImage stretchableImageWithLeftCapWidth:cornerSize topCapHeight:0];
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)shadowImageWithSize:(CGSize)size beginColor:(UIColor *)beginColor endColor:(UIColor *)endColor
{
    size = CGSizeMake([UIScreen mainScreen].scale * size.width, [UIScreen mainScreen].scale * size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGFloat locs[2] = {0.0f, 1.0f};
    CGFloat colors[8] = {
        0.0f,0.0f,0.0f,1.0f,
        1.0f,1.0f,1.0f,1.0f
    };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef grad = CGGradientCreateWithColorComponents (colorSpace, colors, locs, 2);
    CGContextDrawLinearGradient(context, grad, CGPointMake(0,0), CGPointMake(size.width,0), kCGGradientDrawsBeforeStartLocation);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(grad);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
