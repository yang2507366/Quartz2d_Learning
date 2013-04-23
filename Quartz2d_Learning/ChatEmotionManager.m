//
//  ChatEmotionManager.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChatEmotionManager.h"
#import "SVChatEmotion.h"
//#import "TimeTracker.h"
#import "SVImageLabel.h"

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
                SVChatEmotion *ce = [[[SVChatEmotion alloc] init] autorelease];
                ce.code = [[emotionInfo allKeys] lastObject];
                ce.imageName = [emotionInfo objectForKey:ce.code];
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

+ (NSArray *)emotionSymbolList
{
    NSMutableArray *symbolList = [NSMutableArray array];
    NSArray *categoryList = [self.class chatEmotionCategoryList];
    for(NSString *category in categoryList){
        NSArray *emotionList = [self.class chatEmotionListForCategoryName:category];
        for(SVChatEmotion *emo in emotionList){
            [symbolList addObject:emo.code];
        }
    }
    return symbolList;
}

+ (NSString *)imageNameForSymbol:(NSString *)symbol
{
    static NSDictionary *symbolImageDict = nil;
    if(symbolImageDict == nil){
        NSMutableDictionary *tmpSymbolImageDict = [NSMutableDictionary dictionary];
        NSArray *categoryList = [self.class chatEmotionCategoryList];
        for(NSString *category in categoryList){
            NSArray *emotionList = [self.class chatEmotionListForCategoryName:category];
            for(SVChatEmotion *emo in emotionList){
                [tmpSymbolImageDict setObject:emo.imageName forKey:emo.code];
            }
        }
        symbolImageDict = [tmpSymbolImageDict retain];
    }
    return [symbolImageDict objectForKey:symbol];
}

+ (NSString *)replaceChatMessage:(NSString *)msg
{
//    [[TimeTracker defaultTracker] markStartWithIdentifier:self];
    static NSArray *bracketList = nil;
    static NSArray *squareBracketsList = nil;
    static NSArray *otherList = nil;
    if(bracketList == nil){
        NSArray *emotionSymbolList = [self.class emotionSymbolList];
        NSMutableArray *tmpBracketList = [NSMutableArray array];
        NSMutableArray *tmpSquareBracketsList = [NSMutableArray array];
        NSMutableArray *tmpOtherList = [NSMutableArray array];
        for(NSString *symbol in emotionSymbolList){
            if([symbol hasPrefix:@"["]){
                [tmpSquareBracketsList addObject:symbol];
            }else if([symbol hasPrefix:@"("]){
                [tmpBracketList addObject:symbol];
            }else{
                [tmpOtherList addObject:symbol];
            }
        }
        bracketList = [tmpBracketList retain];
        squareBracketsList = [tmpSquareBracketsList retain];
        otherList = [tmpOtherList retain];
    }
    
    NSMutableArray *tmpCheckList = [NSMutableArray arrayWithArray:otherList];
    NSRange tmpRange = [msg rangeOfString:@"["];
    if(tmpRange.location != NSNotFound){
        tmpRange = [msg rangeOfString:@"]" options:NSCaseInsensitiveSearch range:NSMakeRange(tmpRange.location, msg.length - tmpRange.location)];
        if(tmpRange.location != NSNotFound){
            [tmpCheckList addObjectsFromArray:squareBracketsList];
        }
    }
    tmpRange = [msg rangeOfString:@"("];
    if(tmpRange.location != NSNotFound){
        tmpRange = [msg rangeOfString:@")" options:NSCaseInsensitiveSearch range:NSMakeRange(tmpRange.location, msg.length - tmpRange.location)];
        if(tmpRange.location != NSNotFound){
            [tmpCheckList addObjectsFromArray:bracketList];
        }
    }
    for(NSString *symbol in tmpCheckList){
        msg = [msg stringByReplacingOccurrencesOfString:symbol withString:[NSString stringWithFormat:@"%@%@%@", SVImageLabelDefaultImageLeftMatchingText, [self imageNameForSymbol:symbol], SVImageLabelDefaultImageRightMatchingText]];
    }
//    NSLog(@"cost time:%f", [[TimeTracker defaultTracker] timeIntervalForIdentifier:self]);
    return msg;
}

@end
