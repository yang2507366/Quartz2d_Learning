//
//  ChatEmotionView.h
//  TheFansBook
//
//  Created by yzx on 12-8-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatEmotionView;

@protocol ChatEmotionViewDelegate <NSObject>

@optional
- (UIView *)chatEmotionView:(ChatEmotionView *)chatEmotionView viewAtRow:(NSInteger)row column:(NSInteger)column;

@end

@interface ChatEmotionView : UIView

@property(nonatomic, retain)id<ChatEmotionViewDelegate> delegate;
@property(nonatomic, assign)NSInteger numberOfRows;
@property(nonatomic, assign)NSInteger numberOfColumns;

@property(nonatomic, assign)CGFloat itemWidth;
@property(nonatomic, assign)CGFloat itemHeight;

- (void)reloadView;

@end
