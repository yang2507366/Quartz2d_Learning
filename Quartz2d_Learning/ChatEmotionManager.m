//
//  ChatEmotionManager.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChatEmotionManager.h"
#import "ChatEmotion.h"

@implementation ChatEmotionManager

+ (NSArray *)emotionList
{
    static NSArray *emotionList = nil;
    if(emotionList == nil){
        emotionList = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emotions" ofType:@"plist"]] retain];
    }
    
    return emotionList;
}

+ (NSArray *)chatEmotionCategoryList
{
    static NSArray *categoryList = nil;
    if(categoryList == nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *emotionList = [self emotionList];
        for(NSInteger i = 0; i < emotionList.count; ++i){
            NSDictionary *dict = [emotionList objectAtIndex:i];
            NSString *categoryName = [[dict allKeys] lastObject];
            [array addObject:categoryName];
        }
        categoryList = array;
    }
    return categoryList;
}

+ (NSArray *)chatEmotionListForCategoryName:(NSString *)categoryName
{
    NSArray *emotionList = [self emotionList];
    for(NSInteger i = 0; i < emotionList.count; ++i){
        NSDictionary *dict = [emotionList objectAtIndex:i];
        NSArray *array = [dict objectForKey:categoryName];
        if(array){
            NSMutableArray *chatEmotionList = [NSMutableArray array];
            for(NSInteger j = 0; j < array.count; ++j){
                NSDictionary *emotionInfo = [array objectAtIndex:j];
                ChatEmotion *ce = [[[ChatEmotion alloc] init] autorelease];
                ce.symbol = [[emotionInfo allKeys] lastObject];
                ce.imageName = [emotionInfo objectForKey:ce.symbol];
                [chatEmotionList addObject:ce];
            }
            return chatEmotionList;
        }
    }
    return nil;
}

+ (NSDictionary *)chatEmotionDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *emotionCategoryList = [self chatEmotionCategoryList];
    for(NSString *category in emotionCategoryList){
        [dict setObject:[self chatEmotionListForCategoryName:category] forKey:category];
    }
    return dict;
}

@end
