//
//  MsgLabel.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SVImageLabel.h"

@interface SVImageLabel ()

@property(nonatomic, assign)CGFloat realHeight;

@end

@implementation SVImageLabel

- (void)dealloc
{
    self.text = nil;
    self.font = nil;
    self.textColor = nil;
    self.imageGetter = nil;
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
    
    NSString *text = self.text;
    if(!self.text){
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    CGContextSetFillColorWithColor(context, self.textColor.CGColor);
    
    NSString *identifier = @"{IMG=";
    CGFloat tmpX = 0.0f;
    CGFloat tmpY = 0.0f;
    CGFloat tmpLineHeight = self.font.lineHeight;
    for(NSInteger i = 0; i < text.length; ++i){
        NSString *ch = [text substringWithRange:NSMakeRange(i, 1)];
        if([ch isEqualToString:@"{"]){
            if(i + identifier.length < text.length){
                NSString *pp = [text substringWithRange:NSMakeRange(i, identifier.length)];
                if([pp isEqualToString:identifier]){
                    NSRange tmpRange = [text rangeOfString:@"}" options:NSCaseInsensitiveSearch range:NSMakeRange(i, text.length - i)];
                    if(tmpRange.location != NSNotFound){
                        NSString *imageName = [text substringWithRange:NSMakeRange(i + identifier.length, tmpRange.location - i - identifier.length)];
                        i = tmpRange.location;
                        
                        UIImage *img = nil;
                        if(self.imageGetter){
                            img = self.imageGetter(imageName);
                        }else{
                            img = [UIImage imageNamed:imageName];
                        }
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

- (void)setText:(NSString *)m
{
    if(_text != m){
        [_text release];
        _text = [m copy];
    }
    [self setNeedsDisplay];
}

- (void)resizeToSuitableHeight
{
    [self drawRect:self.bounds];
    CGRect rect = self.frame;
    rect.size.height = self.realHeight;
    self.frame = rect;
}

@end
