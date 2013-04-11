//
//  MsgLabel.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SVMsgLabel.h"

@interface SVMsgLabel ()

@property(nonatomic, assign)CGFloat realHeight;

@end

@implementation SVMsgLabel

@synthesize msg;
@synthesize font;
@synthesize textColor;

- (void)dealloc
{
    self.msg = nil;
    self.font = nil;
    self.textColor = nil;
    [super dealloc];
}

- (id)init
{
    self = [self initWithFrame:CGRectZero];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.font = [UIFont systemFontOfSize:14.0f];
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    CGContextSetFillColorWithColor(context, self.textColor.CGColor);
    
    if(!self.msg){
        return;
    }
    
    NSString *identifier = @"{IMG=";
    CGFloat tmpX = 0.0f;
    CGFloat tmpY = 0.0f;
    CGFloat tmpLineHeight = self.font.lineHeight;
    for(NSInteger i = 0; i < self.msg.length; ++i){
        NSString *ch = [self.msg substringWithRange:NSMakeRange(i, 1)];
        if([ch isEqualToString:@"{"]){
            if(i + identifier.length < self.msg.length){
                NSString *pp = [self.msg substringWithRange:NSMakeRange(i, identifier.length)];
                if([pp isEqualToString:identifier]){
                    NSRange tmpRange = [self.msg rangeOfString:@"}" options:NSCaseInsensitiveSearch range:NSMakeRange(i, self.msg.length - i)];
                    if(tmpRange.location != NSNotFound){
                        NSString *imageName = [self.msg substringWithRange:NSMakeRange(i + identifier.length, tmpRange.location - i - identifier.length)];
                        i = tmpRange.location;
                        
                        UIImage *img = [UIImage imageNamed:imageName];
                        if(tmpX + img.size.width >= rect.size.width){
                            tmpY += tmpLineHeight;
                            tmpX = 0;
                        }
                        tmpLineHeight = img.size.height > tmpLineHeight ? img.size.height : tmpLineHeight;
                        [img drawAtPoint:CGPointMake(tmpX, tmpY)];
                        tmpX += img.size.width;
                        continue;
                    }
                }
            }
        }
        CGFloat strWidth = [ch sizeWithFont:self.font].width;
        if(tmpX + strWidth >= rect.size.width){
            tmpX = 0;
            tmpY += tmpLineHeight;
            tmpLineHeight = self.font.lineHeight;
        }
        [ch drawAtPoint:CGPointMake(tmpX, tmpY) withFont:self.font];
        tmpX += strWidth;
    }
    self.realHeight = tmpY + tmpLineHeight;;
}

- (void)setMsg:(NSString *)m
{
    if(msg != m){
        [msg release];
        msg = [m copy];
    }
    [self setNeedsDisplay];
}

- (void)fitToRealHeight
{
    [self drawRect:self.bounds];
    CGRect rect = self.frame;
    rect.size.height = self.realHeight;
    self.frame = rect;
}

@end
