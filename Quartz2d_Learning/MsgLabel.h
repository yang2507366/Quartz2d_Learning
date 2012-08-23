//
//  MsgLabel.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgLabel : UIView

@property(nonatomic, copy)NSString *msg;
@property(nonatomic, retain)UIFont *font;

- (void)fitToRealHeight;

@end
