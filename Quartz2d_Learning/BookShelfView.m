//
//  BookShelfView.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-2-19.
//
//

#import "BookShelfView.h"
#import "GridViewWrapper.h"
#import <QuartzCore/QuartzCore.h>

#define kBookWidth 80
#define kBookHeight 100

@interface BookShelfView () <GridViewWrapperDelegate>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)GridViewWrapper *gridViewWrapper;

@property(nonatomic, retain)UIView *coverView;
@property(nonatomic, retain)UIView *bottomView;
@property(nonatomic, assign)CGFloat openX;
@property(nonatomic, assign)CGFloat openY;

@end

@implementation BookShelfView

- (void)dealloc
{
    self.tableView = nil;
    self.gridViewWrapper = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.gridViewWrapper = [[[GridViewWrapper alloc] initWithNumberOfColumns:4] autorelease];
    self.gridViewWrapper.delegate = self;
    self.tableView = [[[UITableView alloc] initWithFrame:self.bounds] autorelease];
    self.tableView.dataSource = self.gridViewWrapper;
    [self addSubview:self.tableView];
    
    self.bottomView = [[[UIView alloc] initWithFrame:self.coverView.frame] autorelease];
    self.bottomView.backgroundColor = [UIColor greenColor];
    self.bottomView.hidden = YES;
    [self.bottomView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBook)] autorelease]];
    [self addSubview:self.bottomView];
    
    self.coverView = [[[UIView alloc] initWithFrame:CGRectMake(20, 320, kBookWidth, kBookHeight)] autorelease];
    self.coverView.backgroundColor = [UIColor blueColor];
    self.coverView.hidden = YES;
    [self addSubview:self.coverView];
    
    return self;
}

- (NSInteger)numberOfItemsInGridViewWrapper:(GridViewWrapper *)gridViewWrapper
{
    return 20;
}

- (void)gridViewWrapper:(GridViewWrapper *)gridViewWrapper configureView:(UIView *)view atIndex:(NSInteger)index
{
    UILabel *label = (id)[view viewWithTag:1001];
    if(!label){
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width - 10, view.frame.size.height - 10)] autorelease];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"%d", index];
}

- (void)gridViewWrapper:(GridViewWrapper *)gridViewWrapper viewItemTappedAtIndex:(NSInteger)index
{
    NSInteger row = index / 4;
    NSInteger column = index - row * 4;
    NSLog(@"%d, %d", row, column);
    CGFloat x = column * self.tableView.frame.size.width / self.gridViewWrapper.numberOfColumns;
    CGFloat y = row * self.tableView.frame.size.width / self.gridViewWrapper.numberOfColumns;
    NSLog(@"%f, %f", x, y);
    CGRect tmpRect = self.coverView.frame;
    tmpRect.origin.x = x;
    tmpRect.origin.y = y;
    self.openX = x;
    self.openY = y;
    self.coverView.frame = tmpRect;
    self.bottomView.frame = tmpRect;
    self.coverView.hidden = NO;
    self.bottomView.hidden = NO;
    [self.class pageOpen:self.coverView duration:1.0f];
    [UIView animateWithDuration:1.0f animations:^{
        CGRect tmpRect = self.coverView.frame;
        tmpRect.origin.x = 0;
        tmpRect.origin.y = 0;
        tmpRect.size.width = self.frame.size.width;
        tmpRect.size.height = self.frame.size.height;
        self.coverView.frame = tmpRect;
        self.bottomView.frame = tmpRect;
    }];
}

- (void)closeBook
{
    [self.class pageClose:self.coverView duration:1.0f];
    [UIView animateWithDuration:1.0f animations:^{
        CGRect tmpRect = self.coverView.frame;
        tmpRect.origin.x = self.openX;
        tmpRect.origin.y = self.openY;
        tmpRect.size.width = kBookWidth;
        tmpRect.size.height = kBookHeight;
        self.coverView.frame = tmpRect;
        self.bottomView.frame = tmpRect;
    }];
}

+ (void)pageOpen:(UIView *)targetView duration:(NSTimeInterval)duration
{
    [targetView.layer removeAllAnimations];
    
    targetView.hidden = NO;
    
    targetView.userInteractionEnabled = NO;
    if (targetView.layer.anchorPoint.x != 0.0f) {
        targetView.layer.anchorPoint = CGPointMake(0.0f, 0.5f);
        targetView.center = CGPointMake(targetView.center.x - targetView.bounds.size.width/2.0f, targetView.center.y);
    }
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    transformAnimation.duration = duration;
    transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    CATransform3D endTransform = CATransform3DMakeRotation(M_PI / 1.50f,
                                                           0.0f,
                                                           -1.0f,
                                                           0.0f);
    endTransform.m34 = 0.001f;
    endTransform.m14 = -0.0015f;
    transformAnimation.toValue = [NSValue valueWithCATransform3D:endTransform];
    CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    theGroup.duration = duration;
    theGroup.fillMode = kCAFillModeForwards;
    theGroup.animations = [NSArray arrayWithObjects:transformAnimation, nil];
    theGroup.removedOnCompletion = NO;
    [targetView.layer addAnimation:theGroup forKey:@"flip"];
}

+ (void)pageClose:(UIView *)targetView duration:(NSTimeInterval)duration
{
    [targetView.layer removeAllAnimations];
    
    targetView.hidden = NO;
    
    targetView.userInteractionEnabled = NO;
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    transformAnimation.duration = duration;
    transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CATransform3D startTransform = CATransform3DMakeRotation(M_PI / 1.50f,
                                                             0.0f,
                                                             -1.0f,
                                                             0.0f);
    startTransform.m34 = 0.001f;
    startTransform.m14 = -0.0015f;
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:startTransform];
    CATransform3D endTransform = CATransform3DIdentity;
    transformAnimation.toValue = [NSValue valueWithCATransform3D:endTransform];
    CAAnimationGroup *theGroup = [CAAnimationGroup animation];
    theGroup.duration = duration;
    theGroup.fillMode = kCAFillModeForwards;
    theGroup.animations = [NSArray arrayWithObjects:transformAnimation, nil];
    theGroup.removedOnCompletion = NO;
    [targetView.layer addAnimation:theGroup forKey:@"flip"];
}

@end
