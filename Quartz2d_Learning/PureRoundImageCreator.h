//
//  PureRoundImageCreator.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-11-23.
//
//

#import <Foundation/Foundation.h>

@interface PureRoundImageCreator : NSObject

+ (UIImage *)createPureColorRoundImageWithColor:(UIColor *)color size:(CGSize)size roundSize:(CGFloat)roundSize;

@end
