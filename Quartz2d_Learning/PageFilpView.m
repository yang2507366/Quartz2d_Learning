//
//  PageFilpView.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-2-19.
//
//

#import "PageFilpView.h"
#import <QuartzCore/QuartzCore.h>

@interface PageFilpView ()

@property(nonatomic, retain)UIView *coverView;
@property(nonatomic, retain)UIView *bottomView;

@end

@implementation PageFilpView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.coverView = [[[UIView alloc] initWithFrame:CGRectMake(20, 320, 80, 100)] autorelease];
    self.coverView.backgroundColor = [UIColor blueColor];
    
    self.bottomView = [[[UIView alloc] initWithFrame:self.coverView.frame] autorelease];
    self.bottomView.backgroundColor = [UIColor greenColor];
    
    [self addSubview:self.bottomView];
    [self addSubview:self.coverView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(20, 320, 80, 40);
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return self;
}

- (void)buttonTapped
{
    static BOOL fliped = NO;
    if(!fliped){
        [self.class pageOpen:self.coverView duration:1.0f];
        fliped = YES;
    }else{
        [self.class pageClose:self.coverView duration:1.0f];
        fliped = NO;
    }
    __block typeof(self) bself = self;
    [UIView animateWithDuration:1.0f animations:^{
        bself.coverView.frame = CGRectMake(20, 320, 160, 200);
        bself.bottomView.frame = CGRectMake(20, 320, 160, 200);
    } completion:^(BOOL finished) {
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
