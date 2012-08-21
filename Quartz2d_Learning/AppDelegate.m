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

@interface AppDelegate () <ChatEmotionSelectViewDelegate>

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
    
    
    SimpleRect *simpleRect = [[[SimpleRect alloc] init] autorelease];
    simpleRect.frame = CGRectMake(20, 40, 200, 300);
//    [self.window addSubview:simpleRect];
    
    Transform_01 *t = [[[Transform_01 alloc] init] autorelease];
    t.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
//    [self.window addSubview:t];
    
    PaintWithAlphaAndRotateTransform *p = [[[PaintWithAlphaAndRotateTransform alloc] init] autorelease];
    p.frame = self.window.bounds;
//    [self.window addSubview:p];
    
    DashLineRect *d = [[[DashLineRect alloc] init] autorelease];
    d.frame = self.window.bounds;
//    [self.window addSubview:d];
    ClippingDrawing *c = [[[ClippingDrawing alloc] init] autorelease];
    c.frame = self.window.bounds;
//    [self.window addSubview:c];
    
    UIImageView *imgView = [[[UIImageView alloc] init] autorelease];
//    [self.window addSubview:imgView];
    imgView.frame = CGRectMake(20, 40, 50, 50);
    imgView.image = [self createImage:imgView.bounds];
    
//    int hexColor = 0xb3b373;
//    int red = (hexColor) >> 16;
//    int green = (hexColor & 0xFF00) >> 8;
//    int blue = (hexColor & 0xFF);
//    
//    NSLog(@"%f, %f, %f", ((float)red) / 255.0f, ((float)green) / 255.0f, ((float)blue) / 255.0f);
    
//    ScreenTestView *v = [[[ScreenTestView alloc] init] autorelease];
//    [self.window addSubview:v];
//    NSArray *symbolList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"symbol" ofType:@"plist"]];
//    NSArray *imageList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image" ofType:@"plist"]];
//    NSMutableString *str = [NSMutableString string];
//    [str appendFormat:@"\n<array>\n"];
//    for(NSInteger i = 42; i < symbolList.count; ++i){
//        [str appendFormat:@"<dict>\n<key>%@</key>\n<string>%@</string>\n</dict>\n", [symbolList objectAtIndex:i], [imageList objectAtIndex:i]];
//    }
//    [str appendFormat:@"</array>"];
//    NSLog(@"%@", str);
    NSArray *emotionCategoryList = [ChatEmotionManager chatEmotionCategoryList];
    for(NSInteger i = 0; i < emotionCategoryList.count; ++i){
        ChatEmotionSelectView *csv = [[[ChatEmotionSelectView alloc] initWithFrame:CGRectMake(0, i * 120 + 40, 320, 120)] autorelease];
        csv.delegate = self;
        csv.title = [emotionCategoryList objectAtIndex:i];
        NSArray *chatEmtionList = [ChatEmotionManager chatEmotionListForCategoryName:[emotionCategoryList objectAtIndex:i]];
        NSLog(@"%@", chatEmtionList);
        NSMutableArray *imageList = [NSMutableArray array];
        for(NSInteger j = 0; j < chatEmtionList.count; ++j){
            ChatEmotion *ce = [chatEmtionList objectAtIndex:j];
            [imageList addObject:ce.imageName];
        }
        csv.emotionList = imageList;
        [self.window addSubview:csv];
        [self.window addSubview:csv];
    }
    
    PageIndicator *pi = [[PageIndicator alloc] initWithNumberOfPages:5];
    pi.frame = CGRectMake(10, 300, 200, 20);
    [pi setCurrentPageIndex:2];
    [pi setIndicatorSize:10];
    [self.window addSubview:pi];
    pi.normalBackgroundColor = [UIColor blackColor];
    pi.highlightBackgroundColor = [UIColor redColor];
    
    return YES;
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
