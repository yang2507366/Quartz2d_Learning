//
//  PureRoundImageCreator.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-11-23.
//
//

#import "PureRoundImageCreator.h"

@implementation PureRoundImageCreator

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

+ (UIImage *)createPureColorRoundImageWithColor:(UIColor *)color size:(CGSize)size roundSize:(CGFloat)roundSize
{
    CGFloat paintRoundSize = roundSize;
    if([UIScreen mainScreen].scale > 1){
        size = CGSizeMake(size.width * 2, size.height * 2);
        paintRoundSize *= 2;
    }
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    AddRoundedRectToPath(context, CGRectMake(0, 0, size.width, size.height), paintRoundSize, paintRoundSize);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    resultImage = [UIImage imageWithCGImage:resultImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    resultImage = [resultImage stretchableImageWithLeftCapWidth:roundSize topCapHeight:0];
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
