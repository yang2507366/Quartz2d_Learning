//
//  EmotionView.h
//  Quartz2d_Learning
//
//  Created by yzx on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmotionView;
@class ChatEmotion;

@protocol EmotionViewDelegate <NSObject>

@optional
- (void)emotionView:(EmotionView *)emoView didSelectEmotion:(ChatEmotion *)chatEmo;
- (void)emotionViewDeleteButtonDidTapped:(EmotionView *)emoView;

@end

@interface EmotionView : UIView

@property(nonatomic, assign)id<EmotionViewDelegate> delegate;
@property(nonatomic, retain)NSArray *emotionCategoryList;
@property(nonatomic, retain)NSDictionary *emotionDictionary;

@end
