//
//  MyOperation.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-3-21.
//
//

#import "MyOperation.h"

@implementation MyOperation

- (void)dealloc
{
    self.URLString = nil;
    [super dealloc];
}

- (void)main
{
    NSString *str = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.URLString] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@, response:%d", self.URLString, str.length);
}

@end
