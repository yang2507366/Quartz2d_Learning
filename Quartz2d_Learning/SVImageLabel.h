//
//  MsgLabel.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

OBJC_EXPORT NSString *SVImageLabelDefaultImageLeftMatchingText;
OBJC_EXPORT NSString *SVImageLabelDefaultImageRightMatchingText;

@interface SVImageLabel : UIView

@property(nonatomic, copy)NSString *text;
@property(nonatomic, retain)UIFont *font;
@property(nonatomic, retain)UIColor *textColor;

/**
 custom view for given image name, return a view that will be add to label instead of default image view
 */
@property(nonatomic, copy)UIView *(^viewGetter)(NSString *imageName);

/**
 custom image getter
 */
@property(nonatomic, copy)UIImage *(^imageGetter)(NSString *imageName);

@property(nonatomic, copy)NSString *imageLeftMatchingText;
@property(nonatomic, copy)NSString *imageRightMatchingText;

- (void)resizeToSuitableHeight;

@end
