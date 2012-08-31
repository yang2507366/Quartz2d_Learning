//
//  TabSwitchView.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TabSwitchView;

@protocol TabSwitchViewDelegate <NSObject>

@optional
- (void)tabSwitchView:(TabSwitchView *)switchView didChangeToIndex:(NSInteger)index;

@end

@interface TabSwitchView : UIView

@property(nonatomic, assign)id<TabSwitchViewDelegate> delegate;
@property(nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic, retain)NSArray *titleList;

- (UIView *)viewForTitle:(NSString *)title;
- (UIView *)viewAtIndex:(NSInteger)index;

@end
