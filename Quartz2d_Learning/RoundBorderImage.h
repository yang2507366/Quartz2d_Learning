//
//  RoundBorderImage.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-3-22.
//
//

#import <Foundation/Foundation.h>

@interface RoundBorderImage : NSObject

+ (UIImage *)roundBorderImageWithSize:(CGSize)size cornerSize:(CGFloat)cornerSize strokeColor:(UIColor *)strokeColor stokeSize:(CGFloat)stokeSize;
+ (UIImage *)shadowImageWithSize:(CGSize)size beginColor:(UIColor *)beginColor endColor:(UIColor *)endColor;

@end
