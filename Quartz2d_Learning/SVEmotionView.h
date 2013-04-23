//
//  EmotionView.h
//  Quartz2d_Learning
//
//  Created by yzx on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SVEmotionView;
@class SVChatEmotion;

@protocol SVEmotionViewDelegate <NSObject>

@optional
- (void)emotionView:(SVEmotionView *)emoView didSelectEmotion:(SVChatEmotion *)chatEmo;
- (void)emotionViewDeleteButtonDidTapped:(SVEmotionView *)emoView;

@end

@interface SVEmotionView : UIView

@property(nonatomic, assign)id<SVEmotionViewDelegate> delegate;
@property(nonatomic, retain)NSArray *categories;
@property(nonatomic, retain)NSDictionary *keyCategoryValueEmotions;

@end
