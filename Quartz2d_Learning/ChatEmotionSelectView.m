//
//  ChatEmotionSelectView.m
//  Test
//
//  Created by yzx on 12-8-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChatEmotionSelectView.h"
#import "iCarousel.h"
#import "ChatEmotionView.h"

#define COLUMN_CAPACITY 7
#define ROW_CAPACITY 3

@interface ChatEmotionSelectView () <iCarouselDelegate, iCarouselDataSource, ChatEmotionViewDelegate>

@property(nonatomic, retain)iCarousel *carousel;

@end

@implementation ChatEmotionSelectView

@synthesize delegate;
@synthesize isTextEmotion;
@synthesize emotionList;
@synthesize numberOfRows;
@synthesize numberOfColumns;

@synthesize carousel;

- (void)dealloc
{
    [self.emotionList release];
    self.carousel = nil;
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
    
    self.numberOfColumns = COLUMN_CAPACITY;
    self.numberOfRows = ROW_CAPACITY;
    
    self.carousel = [[[iCarousel alloc] initWithFrame:self.bounds] autorelease];
    [self addSubview:self.carousel];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.decelerationRate = 0.40f;
    self.carousel.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.carousel.frame = self.bounds;
}

- (void)setEmotionList:(NSArray *)emotionList_
{
    if(emotionList != emotionList_){
        [emotionList release];
        emotionList = nil;
    }
    emotionList = [emotionList_ retain];
    
    [self.carousel reloadData];
    [self setNeedsLayout];
}

- (void)setNumberOfRows:(NSInteger)numOfRows
{
    numberOfRows = numOfRows;
    [self.carousel reloadData];
}

- (void)setNumberOfColumns:(NSInteger)numOfColumns
{
    numberOfColumns = numOfColumns;
    [self.carousel reloadData];
}

#pragma mark - events
- (void)onEmotionItemTapped:(UIButton *)btn
{
    NSLog(@"%@", [self.emotionList objectAtIndex:btn.tag]);
}

#pragma mark - iCarouselDelegate
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSInteger pageSize = self.emotionList.count / (self.numberOfRows * self.numberOfColumns);
    if(self.emotionList.count % (self.numberOfRows * self.numberOfColumns)){
        ++pageSize;
    }
    return pageSize;
}

- (UIView *)carousel:(iCarousel *)carousel_ viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    ChatEmotionView *chatEmoView = nil;
    if(view){
        chatEmoView = (id)view;
    }else{
        chatEmoView = [[[ChatEmotionView alloc] initWithFrame:carousel_.bounds] autorelease];
        chatEmoView.delegate = self;
        chatEmoView.numberOfRows = self.numberOfRows;
        chatEmoView.numberOfColumns = self.numberOfColumns;
    }
    chatEmoView.tag = index;
    [chatEmoView reloadView];
    return chatEmoView;
}

#pragma mark - ChatEmotionViewDelegate
- (UIView *)chatEmotionView:(ChatEmotionView *)chatEmotionView viewAtRow:(NSInteger)row column:(NSInteger)column
{
    NSInteger pageIndex = chatEmotionView.tag;
    NSInteger startIndex = pageIndex * self.numberOfRows * self.numberOfColumns;
    NSInteger targetIndex = startIndex + row * self.numberOfColumns + column;
    if(targetIndex >= self.emotionList.count){
        return nil;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = targetIndex;
    [btn addTarget:self action:@selector(onEmotionItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    if(self.isTextEmotion){
        NSString *text = [self.emotionList objectAtIndex:targetIndex];
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.titleLabel.textAlignment = UITextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
    }else{
        NSString *image = [self.emotionList objectAtIndex:targetIndex];
        UIImage *img = [UIImage imageNamed:image];
        [btn setImage:img forState:UIControlStateNormal];
    }
    
    return btn;
}

@end
