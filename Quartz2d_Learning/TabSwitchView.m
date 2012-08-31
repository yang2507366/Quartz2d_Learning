//
//  TabSwitchView.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define TITLE_WIDTH 68
#define BORDER_COLOR [UIColor colorWithRed:221.0f/255.0f green:219.0f/255.0f blue:202.0f/255.0f alpha:1.0f]

#import "TabSwitchView.h"
#import <QuartzCore/QuartzCore.h>

@class Switcher;

@protocol SwitcherDelegate <NSObject>

@optional
- (void)switcher:(Switcher *)switcher didChangeToIndex:(NSInteger)index;

@end

@interface Switcher : UIView

@property(nonatomic, assign)id<SwitcherDelegate> delegate;
@property(nonatomic, retain)NSArray *titleList;
@property(nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic, retain)NSArray *buttonList;
@property(nonatomic, retain)NSArray *borderViewList;
@property(nonatomic, retain)UIView *maskView;

@end

@implementation Switcher

@synthesize delegate;
@synthesize titleList;
@synthesize selectedIndex;
@synthesize buttonList;
@synthesize borderViewList;
@synthesize maskView;

- (void)dealloc
{
    self.titleList = nil;
    self.buttonList = nil;
    self.borderViewList = nil;
    self.maskView = nil;
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
    
    self.backgroundColor = [UIColor colorWithRed:232.0f/255.0f green:232.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    self.selectedIndex = 0;
    
    self.maskView = [[[UIView alloc] init] autorelease];
    self.maskView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.maskView];
    
    return self;
}

- (CGFloat)usableHeight
{
    return self.bounds.size.height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.titleList.count == 0){
        return;
    }
    
    CGFloat btnWidth = self.bounds.size.width;
    CGFloat btnHeight = self.bounds.size.height / self.titleList.count;
    for(NSInteger i = 0; i < self.buttonList.count; ++i){
        UIButton *btn = [self.buttonList objectAtIndex:i];
        CGFloat tmpY = btnHeight * i - 1;
        CGFloat tmpHeight = btnHeight + 1;
        CGFloat tmpWidth = btnWidth;
        if(i == 0){
            ++tmpY;
            --tmpHeight;
        }
        btn.frame = CGRectMake(0, tmpY, tmpWidth, tmpHeight);
        btn.selected = i == selectedIndex;
        
        UIView *borderView = [self.borderViewList objectAtIndex:i];
        borderView.frame = btn.frame;
    }
    
    CGRect frame = self.maskView.frame;
    frame.origin.y = self.selectedIndex * (self.bounds.size.height / self.titleList.count);
    frame.size.height = btnHeight - 1;
    if(self.selectedIndex == 0){
        ++frame.origin.y;
        --frame.size.height;
    }
    frame.size.width = self.bounds.size.width;
    frame.origin.x = 1;
    self.maskView.frame = frame;
}

- (void)setTitleList:(NSArray *)list
{
    if(titleList != list){
        [titleList release];
        titleList = [list retain];
    }
    if(self.buttonList){
        for(UIButton *btn in self.buttonList){
            [btn removeFromSuperview];
        }
    }
    if(self.borderViewList){
        for(UIView *view in self.borderViewList){
            [view removeFromSuperview];
        }
    }
    if(titleList.count != 0){
        NSMutableArray *tmpBtnList = [NSMutableArray array];
        NSMutableArray *tmpBorderViewList = [NSMutableArray array];
        for(NSInteger i = 0; i < self.titleList.count; ++i){
            UIView *borderView = [[[UIView alloc] init] autorelease];
            borderView.layer.borderWidth = 1.0f;
            borderView.layer.borderColor = BORDER_COLOR.CGColor;
            [self addSubview:borderView];
            [tmpBorderViewList addObject:borderView];
        }
        self.borderViewList = tmpBorderViewList;
        [self bringSubviewToFront:self.maskView];
        for(NSInteger i = 0; i < self.titleList.count; ++i){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            btn.titleLabel.layer.shadowRadius = 0.5f;
            btn.titleLabel.layer.shadowOpacity = 1.0f;
            btn.titleLabel.layer.shadowOffset = CGSizeMake(0, -0.5f);
            btn.titleLabel.layer.shadowColor = [UIColor whiteColor].CGColor;
            [btn setTitleColor:[UIColor colorWithRed:131.0f/255.0f green:128.0f/255.0f blue:98.0f/255.0f alpha:1.0f] 
                      forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:77.0f/255.0f green:187.0f/255.0f blue:206.0f/255.0f alpha:1.0f] 
                      forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(onBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[self.titleList objectAtIndex:i] forState:UIControlStateNormal];
            [self addSubview:btn];
            
            [tmpBtnList addObject:btn];
        }
        self.buttonList = tmpBtnList;
    }
    
    [self setNeedsLayout];
}

- (void)setSelectedIndex:(NSInteger)index
{
    selectedIndex = index;
    
    if(self.titleList.count == 0){
        return;
    }
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationDuration:0.25f];
    CGRect frame = self.maskView.frame;
    frame.origin.y = self.selectedIndex * (self.bounds.size.height / self.titleList.count);
    self.maskView.frame = frame;
    [UIView commitAnimations];
    [self setNeedsLayout];
}

- (void)onBtnTapped:(UIButton *)btn
{
    NSInteger index = btn.tag;
    if(index != self.selectedIndex){
        self.selectedIndex = index;
        if([self.delegate respondsToSelector:@selector(switcher:didChangeToIndex:)]){
            [self.delegate switcher:self didChangeToIndex:self.selectedIndex];
        }
    }
}

@end

@interface TabSwitchView () <SwitcherDelegate>

@property(nonatomic, retain)NSArray *viewList;
@property(nonatomic, retain)Switcher *switcher;

@end

@implementation TabSwitchView

@synthesize delegate;
@synthesize selectedIndex;
@dynamic titleList;

@synthesize viewList;
@synthesize switcher;

- (void)dealloc
{
    self.titleList = nil;
    self.viewList = nil;
    self.switcher = nil;
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
    
    self.backgroundColor = [UIColor clearColor];
    self.selectedIndex = 0;
    self.switcher = [[[Switcher alloc] init] autorelease];
    self.switcher.delegate = self;
    [self addSubview:self.switcher];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for(NSInteger i = 0; i < self.viewList.count; ++i){
        UIView *view = [self.viewList objectAtIndex:i];
        view.frame = CGRectMake(TITLE_WIDTH, 1, self.bounds.size.width - TITLE_WIDTH - 1, self.bounds.size.height - 2);
        view.hidden = self.selectedIndex != i;
    }
    self.switcher.frame = CGRectMake(0, 0, TITLE_WIDTH, self.bounds.size.height);
}

- (UIView *)viewForTitle:(NSString *)title
{
    NSUInteger index = [self.titleList indexOfObject:title];
    if(index != NSNotFound){
        return [self viewAtIndex:index];
    }
    
    return nil;
}

- (UIView *)viewAtIndex:(NSInteger)index
{
    return [self.viewList objectAtIndex:index];
}

- (void)setSelectedIndex:(NSInteger)index
{
    self.switcher.selectedIndex = index;
}

- (NSInteger)selectedIndex
{
    return self.switcher.selectedIndex;
}

- (void)setTitleList:(NSArray *)list
{
    self.switcher.titleList = list;
    
    if(self.viewList){
        for(NSString *title in self.titleList){
            UIView *view = [self viewForTitle:title];
            [view removeFromSuperview];
        }
    }
    NSMutableArray *tmpViewList = [NSMutableArray array];
    for(NSString *title in self.titleList){
        UIView *view = [[[UIView alloc] init] autorelease];
        [self addSubview:view];
        [tmpViewList addObject:view];
    }
    self.viewList = tmpViewList;
    [self setNeedsLayout];
}

- (NSArray *)titleList
{
    return self.switcher.titleList;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, BORDER_COLOR.CGColor);
    CGContextStrokeRectWithWidth(context, rect, 2.0f);
}

#pragma mark - SwitcherDelegate
- (void)switcher:(Switcher *)switcher didChangeToIndex:(NSInteger)index
{
    if([self.delegate respondsToSelector:@selector(tabSwitchView:didChangeToIndex:)]){
        [self.delegate tabSwitchView:self didChangeToIndex:index];
    }
    [self setNeedsLayout];
}

@end
