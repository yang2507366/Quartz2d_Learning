//
//  ScreenTestView.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScreenTestView.h"

@interface ScreenTestView ()

@property(nonatomic, retain)NSArray *colorList;

@property(nonatomic)NSInteger currentColorIndex;

@end

@implementation ScreenTestView

@synthesize colorList = _colorList;
@synthesize currentColorIndex = _currentColorIndex;

- (void)dealloc
{
    [_colorList release];
    [super dealloc];
}

- (id)init
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    CGRect fullscreen = [[UIScreen mainScreen] bounds];
    
    self = [super initWithFrame:fullscreen];
    
    NSMutableArray *colorList = [NSMutableArray array];
    [colorList addObject:[UIColor whiteColor]];
    [colorList addObject:[UIColor blackColor]];
    [colorList addObject:[UIColor redColor]];
    [colorList addObject:[UIColor blueColor]];
    [colorList addObject:[UIColor greenColor]];
    [colorList addObject:[UIColor yellowColor]];
    [colorList addObject:[UIColor cyanColor]];
    [colorList addObject:[UIColor magentaColor]];
    self.colorList = colorList;
    self.currentColorIndex = 0;
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, rect);
    UIColor *currentColor = [self.colorList objectAtIndex:self.currentColorIndex];
    CGContextSetFillColorWithColor(context, currentColor.CGColor);
    CGContextDrawPath(context, kCGPathFill);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    ++self.currentColorIndex;
    if(self.currentColorIndex == [self.colorList count]){
        self.currentColorIndex = 0;
    }
    [self setNeedsDisplay];
}

@end
