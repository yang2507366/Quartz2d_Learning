//
//  ChatEmotionSelectView.h
//  Test
//
//  Created by yzx on 12-8-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatEmotionSelectView;

@protocol ChatEmotionSelectViewDelegate <NSObject>

@optional
- (void)chatEmotionSelectView:(ChatEmotionSelectView *)chatEmoSelectView 
  didSelectEmotionAtPageIndex:(NSInteger)pageIndex 
                          row:(NSInteger)row 
                       column:(NSInteger)column;

@end

@interface ChatEmotionSelectView : UIView 

@property(nonatomic, assign)id<ChatEmotionSelectViewDelegate> delegate;
@property(nonatomic, assign)BOOL isTextEmotion;
@property(nonatomic, retain)NSArray *emotionList;
@property(nonatomic, assign)NSInteger numberOfRows;
@property(nonatomic, assign)NSInteger numberOfColumns;

@end
