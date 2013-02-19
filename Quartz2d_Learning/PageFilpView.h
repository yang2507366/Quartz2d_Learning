//
//  PageFilpView.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-2-19.
//
//

#import <Foundation/Foundation.h>

@interface PageFilpView : UIView

+ (void)pageOpen:(UIView *)targetView duration:(NSTimeInterval)duration;
+ (void)pageClose:(UIView *)targetView duration:(NSTimeInterval)duration;

@end
