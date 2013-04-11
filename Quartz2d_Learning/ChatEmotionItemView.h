//
//  ChatEmotionView.h
//  TheFansBook
//
//  Created by yzx on 12-8-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatEmotionItemView;

@protocol ChatEmotionItemViewDelegate <NSObject>

@optional
- (UIView *)chatEmotionItemView:(ChatEmotionItemView *)chatEmotionView viewAtRow:(NSInteger)row column:(NSInteger)column;

@end

@interface ChatEmotionItemView : UIView

@property(nonatomic, retain)id<ChatEmotionItemViewDelegate> delegate;
@property(nonatomic, assign)NSInteger numberOfRows;
@property(nonatomic, assign)NSInteger numberOfColumns;

@property(nonatomic, assign)CGFloat itemWidth;
@property(nonatomic, assign)CGFloat itemHeight;

- (void)reloadView;

@end
