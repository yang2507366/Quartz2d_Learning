//
//  EmotionView.m
//  Quartz2d_Learning
//
//  Created by yzx on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmotionView.h"
#import "ChatEmotionSelectView.h"
#import "ChatEmotion.h"
#import "PageIndicator.h"

@interface EmotionView () <ChatEmotionSelectViewDelegate>

@property(nonatomic, assign)NSInteger currentCategoryIndex;
@property(nonatomic, retain)NSMutableArray *switchButtonList;
@property(nonatomic, retain)NSMutableArray *chatEmotionSelectViewList;
@property(nonatomic, retain)PageIndicator *pageIndicator;
@property(nonatomic, retain)UIButton *deleteButton;

- (NSArray *)emotionListForSelectViewAtCategory:(NSString *)category;

@end

@implementation EmotionView

@synthesize delegate;
@synthesize emotionCategoryList;
@synthesize emotionDictionary;

@synthesize currentCategoryIndex;
@synthesize switchButtonList;
@synthesize chatEmotionSelectViewList;
@synthesize pageIndicator;
@synthesize deleteButton;

- (void)dealloc
{
    self.emotionCategoryList = nil;
    self.emotionDictionary = nil;
    
    self.switchButtonList = nil;
    self.chatEmotionSelectViewList = nil;
    self.pageIndicator = nil;
    self.deleteButton = nil;
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
    
    self.currentCategoryIndex = -1;
    
    self.pageIndicator = [[[PageIndicator alloc] init] autorelease];
    self.pageIndicator.indicatorSize = 5;
    [self addSubview:self.pageIndicator];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.deleteButton setBackgroundColor:[UIColor darkGrayColor]];
    [self.deleteButton setTitle:@"DEL" forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(onDeleteButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteButton];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat deleteBtnWidth = 56;
    CGFloat bototmBtnHeight = 54;
    CGFloat pageIndicatorHeight = 40;
    CGFloat switchBtnWidth = (self.frame.size.width - deleteBtnWidth) / emotionCategoryList.count;
    for(NSInteger i = 0; i < emotionCategoryList.count; ++i){
        ChatEmotionSelectView *selectView = [self.chatEmotionSelectViewList objectAtIndex:i];
        selectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - bototmBtnHeight - pageIndicatorHeight);
        
        UIButton *switchBtn = [self.switchButtonList objectAtIndex:i];
        switchBtn.frame = CGRectMake(switchBtnWidth * i, 
                                     self.frame.size.height - bototmBtnHeight + 1, 
                                     switchBtnWidth, 
                                     bototmBtnHeight - 1);
    }
    
    CGFloat pageIndicatorRealWidth = self.pageIndicator.realWidth;
    CGFloat xposition = (self.frame.size.width - pageIndicatorRealWidth) / 2;
    self.pageIndicator.frame = CGRectMake(xposition, 
                                          self.frame.size.height - bototmBtnHeight - pageIndicatorHeight / 2, 
                                          pageIndicatorRealWidth, 
                                          pageIndicatorHeight);
    self.deleteButton.frame = CGRectMake(self.frame.size.width - deleteBtnWidth, 
                                         self.frame.size.height - bototmBtnHeight, 
                                         deleteBtnWidth, 
                                         bototmBtnHeight);
}

- (void)setEmotionCategoryList:(NSArray *)categoryList
{
    if(emotionCategoryList != categoryList){
        [emotionCategoryList release];
        emotionCategoryList = nil;
    }
    emotionCategoryList = [categoryList retain];
    
    if(self.switchButtonList){
        for(UIView *view in self.switchButtonList){
            [view removeFromSuperview];
        }
        self.switchButtonList = nil;
    }
    if(self.chatEmotionSelectViewList){
        for(UIView *view in self.chatEmotionSelectViewList){
            [view removeFromSuperview];
        }
        self.chatEmotionSelectViewList = nil;
    }
    
    self.switchButtonList = [NSMutableArray array];
    self.chatEmotionSelectViewList = [NSMutableArray array];
    for(NSInteger i = 0; i < self.emotionCategoryList.count; ++i){
        NSString *category = [self.emotionCategoryList objectAtIndex:i];
        
        UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        switchBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [switchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [switchBtn setTitle:category forState:UIControlStateNormal];
        [switchBtn addTarget:self action:@selector(onSwitchBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        switchBtn.tag = i;
        [self.switchButtonList addObject:switchBtn];
        [self addSubview:switchBtn];
        
        ChatEmotionSelectView *selectView = [[[ChatEmotionSelectView alloc] init] autorelease];
        selectView.title = category;
        selectView.delegate = self;
        selectView.emotionList = [self emotionListForSelectViewAtCategory:category];
        selectView.backgroundColor = [UIColor clearColor];
        [self.chatEmotionSelectViewList addObject:selectView];
        [self addSubview:selectView];
    }
    self.currentCategoryIndex = 0;
    
    [self setNeedsLayout];
}

- (void)setEmotionDictionary:(NSDictionary *)dict
{
    if(emotionDictionary != dict){
        [emotionDictionary release];
        emotionDictionary = nil;
    }
    emotionDictionary = [dict retain];
    
    [self setNeedsLayout];
}

- (void)setCurrentCategoryIndex:(NSInteger)index
{
    if(currentCategoryIndex == index){
        return;
    }
    currentCategoryIndex = index;
    
    for(NSInteger i = 0; i < self.chatEmotionSelectViewList.count; ++i){
        ChatEmotionSelectView *view = [self.chatEmotionSelectViewList objectAtIndex:i];
        BOOL currentShow = self.currentCategoryIndex == i;
        view.hidden = !currentShow;
        if(!view.hidden){
            [view scrollToFirstPage];
            self.pageIndicator.numberOfPages = view.pageSize;
            self.pageIndicator.currentPageIndex = 0;
        }
        UIButton *switchBtn = [self.switchButtonList objectAtIndex:i];
        UIColor *color = currentShow ? [UIColor whiteColor] : [UIColor lightGrayColor];
        [switchBtn setBackgroundColor:color];
    }
    [self setNeedsLayout];
}

#pragma mark - private methods
- (NSArray *)emotionListForSelectViewAtCategory:(NSString *)category
{
    NSArray *chatEmotionList = [self.emotionDictionary objectForKey:category];
    if(chatEmotionList){
        NSMutableArray *emotionList = [NSMutableArray array];
        for(NSInteger i = 0; i < chatEmotionList.count; ++i){
            ChatEmotion *emo = [chatEmotionList objectAtIndex:i];
            [emotionList addObject:emo.imageName];
        }
        return emotionList;
    }
    return nil;
}

#pragma mark - events
- (void)onSwitchBtnTapped:(UIView *)view
{
    self.currentCategoryIndex = view.tag;
}

- (void)onDeleteButtonTapped
{
    if([self.delegate respondsToSelector:@selector(emotionViewDeleteButtonDidTapped:)]){
        [self.delegate emotionViewDeleteButtonDidTapped:self];
    }
}

#pragma mark - ChatEmotionSelectViewDelegate
- (void)chatEmotionSelectView:(ChatEmotionSelectView *)chatEmoSelectView didSelectEmotionAtIndex:(NSInteger)index
{
    NSString *category = chatEmoSelectView.title;
    NSArray *emotionList = [self.emotionDictionary objectForKey:category];
    ChatEmotion *emo = [emotionList objectAtIndex:index];
//    NSLog(@"%@, %@", emo.symbol, emo.imageName);
    if([self.delegate respondsToSelector:@selector(emotionView:didSelectEmotion:)]){
        [self.delegate emotionView:self didSelectEmotion:emo];
    }
}

- (void)chatEmotionSelectView:(ChatEmotionSelectView *)chatEmoSelectView didChangeToPageIndex:(NSInteger)pageIndex
{
    self.pageIndicator.currentPageIndex = pageIndex;
}

@end
