//
//  NSOperationQueueLearn.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-3-21.
//
//

#import "NSOperationQueueLearn.h"
#import "MyOperation.h"

@interface NSOperationQueueLearn ()

@property(nonatomic, retain)NSOperationQueue *queue;

@end

@implementation NSOperationQueueLearn

- (void)run
{
    self.queue = [[NSOperationQueue new] autorelease];
    
    MyOperation *tmp = [[MyOperation new] autorelease];
    tmp.URLString = @"http://www.tianya.cn";
    
    MyOperation *apple = [[MyOperation new] autorelease];
    apple.URLString = @"http://www.apple.com";

    [tmp addDependency:apple];
    
    [self.queue addOperation:apple];
    [self.queue addOperation:tmp];
}

@end
