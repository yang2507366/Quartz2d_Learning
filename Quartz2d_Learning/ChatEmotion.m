//
//  ChatEmotion.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 12-8-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChatEmotion.h"

@implementation ChatEmotion

@synthesize symbol;
@synthesize imageName;

- (void)dealloc
{
    self.symbol = nil;
    self.imageName = nil;
    [super dealloc];
}

@end
