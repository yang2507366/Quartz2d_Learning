//
//  ChatEmotionManager.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatEmotionManager : NSObject

+ (NSArray *)chatEmotionCategoryList;
+ (NSArray *)chatEmotionListForCategoryName:(NSString *)categoryName;
+ (NSDictionary *)chatEmotionDictionary;

@end
