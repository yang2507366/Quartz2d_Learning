//
//  MsgLabel.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SVImageLabel.h"

NSString *SVImageLabelDefaultImageLeftMatchingText = @"{IMG";
NSString *SVImageLabelDefaultImageRightMatchingText = @"}";

@interface SVImageLabel ()

@property(nonatomic, assign)CGFloat realHeight;
@property(nonatomic, retain)NSMutableArray *addInSubviews;

@end

@implementation SVImageLabel

- (void)dealloc
{
    self.text = nil;
    self.font = nil;
    self.textColor = nil;
    self.viewGetter = nil;
    self.imageGetter = nil;
    self.addInSubviews = nil;
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
    
    self.imageLeftMatchingText = SVImageLabelDefaultImageLeftMatchingText;
    self.imageRightMatchingText = SVImageLabelDefaultImageRightMatchingText;
    
    self.font = [UIFont systemFontOfSize:14.0f];
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    
    self.addInSubviews = [NSMutableArray array];
    
    return self;
}

- (UIView *)viewForImageName:(NSString *)imageName
{
    if(self.viewGetter){
        UIView *view = self.viewGetter(imageName);
        return view;
    }
    return nil;
}

- (void)drawRect:(CGRect)rect
{
    for(UIView *view in self.addInSubviews){
        [view removeFromSuperview];
    }
    [self drawTextWithRect:rect fakeDraw:NO];
}

- (void)drawTextWithRect:(CGRect)rect fakeDraw:(BOOL)fakeDraw
{
    NSString *text = self.text;
    if(!self.text){
        self.realHeight = [self.font lineHeight];
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(!fakeDraw){
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        CGContextFillRect(context, rect);
        CGContextSetFillColorWithColor(context, self.textColor.CGColor);
    }
    
    NSString *imageLeftMatching = self.imageLeftMatchingText;
    NSString *firstCh = [imageLeftMatching substringToIndex:1];
    NSString *imageRightMatching = self.imageRightMatchingText;
    CGFloat tmpX = 0.0f;
    CGFloat tmpY = 0.0f;
    CGFloat tmpLineHeight = self.font.lineHeight;
    for(NSInteger i = 0; i < text.length; ++i){
        NSString *ch = [text substringWithRange:NSMakeRange(i, 1)];
        if([ch isEqualToString:firstCh]){
            if(i + imageLeftMatching.length < text.length){
                NSString *pp = [text substringWithRange:NSMakeRange(i, imageLeftMatching.length)];
                if([pp isEqualToString:imageLeftMatching]){
                    NSRange tmpRange = [text rangeOfString:imageRightMatching options:NSCaseInsensitiveSearch range:NSMakeRange(i, text.length - i)];
                    if(tmpRange.location != NSNotFound){
                        NSString *imageName = [text substringWithRange:NSMakeRange(i + imageLeftMatching.length, tmpRange.location - i - imageLeftMatching.length)];
                        
                        UIView *view = [self viewForImageName:imageName];
                        if(view){
                            if(!fakeDraw){
                                [self.addInSubviews addObject:view];
                            }
                            CGRect tmpRect = view.frame;
                            if(tmpX + tmpRect.size.width >= rect.size.width){
                                tmpY += tmpLineHeight;
                                tmpX = 0;
                            }
                            tmpRect.origin.x = tmpX;
                            tmpRect.origin.y = tmpY;
                            view.frame = tmpRect;
                            if(!fakeDraw){
                                [self addSubview:view];
                            }
                            
                            tmpX += tmpRect.size.width;
                            tmpLineHeight = tmpRect.size.height > tmpLineHeight ? tmpRect.size.height : tmpLineHeight;
                            
                            i = tmpRange.location;
                            continue;
                        }else{
                            UIImage *img = nil;
                            if(self.imageGetter){
                                img = self.imageGetter(imageName);
                            }else{
                                img = [UIImage imageNamed:imageName];
                            }
                            if(img){
                                if(tmpX + img.size.width >= rect.size.width){
                                    tmpY += tmpLineHeight;
                                    tmpX = 0;
                                }
                                tmpLineHeight = img.size.height > tmpLineHeight ? img.size.height : tmpLineHeight;
                                if(!fakeDraw){
                                    [img drawAtPoint:CGPointMake(tmpX, tmpY)];
                                }
                                tmpX += img.size.width;
                                
                                i = tmpRange.location;
                                continue;
                            }
                        }
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
        if(!fakeDraw){
            [ch drawAtPoint:CGPointMake(tmpX, tmpY) withFont:self.font];
        }
        tmpX += strWidth;
    }
    self.realHeight = tmpY + tmpLineHeight;
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
    [self drawTextWithRect:self.bounds fakeDraw:YES];
    CGRect rect = self.frame;
    rect.size.height = self.realHeight;
    self.frame = rect;
}

@end
