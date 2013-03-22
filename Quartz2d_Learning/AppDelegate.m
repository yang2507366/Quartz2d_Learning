//
//  AppDelegate.m
//  Quartz2d_Learning
//
//  Created by gewara on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SimpleRect.h"
#import "Transform_01.h"
#import "PaintWithAlphaAndRotateTransform.h"
#import "DashLineRect.h"
#import "ClippingDrawing.h"
#import "ScreenTestView.h"
#import "ChatEmotionSelectView.h"
#import "ChatEmotionManager.h"
#import "ChatEmotion.h"
#import "PageIndicator.h"
#import "EmotionView.h"
#import "MsgLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "TabSwitchView.h"
#import "DrawImgTest.h"
#import "PureRoundImageCreator.h"
#import "PageFilpView.h"
#import "BookShelfView.h"
#import "QRFindReplaceView.h"
#import "Sort.h"
#import "NSOperationQueueLearn.h"
#import "RoundBorderImage.h"

@interface AppDelegate () <ChatEmotionSelectViewDelegate, EmotionViewDelegate, TabSwitchViewDelegate>

@end

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (UIImage *)createImage:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, 
                                                 rect.size.width, 
                                                 rect.size.height, 
                                                 8, 
                                                 4 * rect.size.width, 
                                                 colorSpace, 
                                                 kCGImageAlphaPremultipliedFirst
                                                 );
    CGContextSetShouldAntialias(context, YES);
    CGContextSetRGBFillColor(context, 0.0f, 0.0f, 1.0f, 1.0f);
    CGContextFillRect(context, rect);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, rect.size.width / 2, 0.0f, 2 * M_PI, 0);
    CGContextSetRGBFillColor(context, 0.0f, 1.0f, 0.0f, 1.0f);
    CGContextDrawPath(context, kCGPathFill);
    
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:imgRef];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 100, 100)] autorelease];
    imageView.contentMode = UIViewContentModeCenter;
    [imageView setImage:[RoundBorderImage roundBorderImageWithSize:CGSizeMake(40, 20) cornerSize:10 strokeColor:[UIColor redColor] stokeSize:2]];
    [self.window addSubview:imageView];
    
    return YES;
}

#pragma mark - TabSwitchViewDelegate
- (void)tabSwitchView:(TabSwitchView *)switchView didChangeToIndex:(NSInteger)index
{
}

#pragma mark - EmotionViewDelegate
- (void)emotionView:(EmotionView *)emoView didSelectEmotion:(ChatEmotion *)chatEmo
{
    NSLog(@"%@", chatEmo);
}

#pragma mark - ChatEmotionSelectViewDelegate
- (void)chatEmotionSelectView:(ChatEmotionSelectView *)chatEmoSelectView didSelectEmotionAtIndex:(NSInteger)index
{
    ChatEmotion *ce = [[ChatEmotionManager chatEmotionListForCategoryName:chatEmoSelectView.title] objectAtIndex:index];
    NSLog(@"%@:%@", chatEmoSelectView.title, ce.symbol);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
