//
//  MsgLabel.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVImageLabel : UIView

@property(nonatomic, copy)NSString *text;
@property(nonatomic, retain)UIFont *font;
@property(nonatomic, retain)UIColor *textColor;
@property(nonatomic, copy)UIImage *(^imageGetter)(NSString *image);

- (void)resizeToSuitableHeight;

@end
