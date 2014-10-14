//
//  BZWWaveTransaction.m
//  BZWaveTransaction
//
//  Created by Bruce on 14-7-30.
//  Copyright (c) 2014年 com.Bruce.Wave. All rights reserved.
//

#import "BZWWaveTransaction.h"

#define MAX_DELAY   0.15
#define DURATION    0.65
#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
@interface BZWWaveTransaction()

@property (retain, nonatomic) UIView *viewCopyForNew;

@end

@implementation BZWWaveTransaction

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 3;
}

- (BOOL)pushWaveTransactionFromVC:(UIViewController<BZWTransactionDelegate> *)fromVC
                             toVC:(UIViewController<BZWTransactionDelegate> *)toVC {
    self.operation = UINavigationControllerOperationPush;
    return [self waveTransactionFromVC:fromVC toVC:toVC];
}

- (BOOL)popWaveTransactionFromVC:(UIViewController<BZWTransactionDelegate> *)fromVC
                            toVC:(UIViewController<BZWTransactionDelegate> *)toVC {
    self.operation = UINavigationControllerOperationPop;
    return [self waveTransactionFromVC:fromVC toVC:toVC];
}

- (BOOL)waveTransactionFromVC:(UIViewController<BZWTransactionDelegate> *)fromVC
                         toVC:(UIViewController<BZWTransactionDelegate> *)toVC {
    if (!fromVC.navigationController) {
        return NO;
    }
    
    CGFloat delta;
    if (self.operation == UINavigationControllerOperationPush) {
        delta = SCREEN_WIDTH;
    } else {
        delta = -SCREEN_WIDTH;
    }
    
    float navigationHeight = fromVC.navigationController.navigationBar.frame.size.height;
    float statusBarHeight = 20;
    CGRect copyViewFrame = fromVC.view.frame;
    copyViewFrame.origin.y = navigationHeight + statusBarHeight;
    
    // 将下一个页面的View加在第一个页面上，用于实现动画效果。
    CGRect firstFrame = fromVC.view.frame;//frame的y值为20, 改为0。
    if (RequireSysVerGreaterOrEqual(@"7.0")) {
        firstFrame.origin.y = -(navigationHeight + statusBarHeight);
    } else {
        firstFrame.origin.y = 0;
    }
    fromVC.view.frame = firstFrame;
    
    CGRect secondFrame = toVC.view.frame;//frame的y值为20, 改为0。
    secondFrame.origin.y = 0;
    toVC.view.frame = secondFrame;
    
    self.viewCopyForNew = [[UIView alloc] initWithFrame:copyViewFrame];
    // 将前后两个页面的view添加到第三方view中（如果两个页面互相添加，会crash）
    [self.viewCopyForNew addSubview:fromVC.view];
    [self.viewCopyForNew addSubview:toVC.view];
    [fromVC.navigationController.view addSubview:self.viewCopyForNew];
    
    if ([fromVC respondsToSelector:@selector(transactionCells)]) {
        // 波浪动画效果实现方法
        // enumerateObjectsWithOptions是将数列里的对象按序执行block内操作
        [[fromVC transactionCells] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UITableViewCell *obj, NSUInteger idx, BOOL *stop) {
            NSTimeInterval delay = ((float)idx / (float)[[fromVC transactionCells] count]) * MAX_DELAY;
            [self hideView:obj withDelay:delay andDelta:-delta];
        }];
    } else {
        [self hideView:fromVC.view withDelay:0 andDelta:-delta];
    }
    
    if ([toVC respondsToSelector:@selector(transactionCells)]) {
        [[toVC transactionCells] enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UITableViewCell *obj, NSUInteger idx, BOOL *stop) {
            NSTimeInterval delay = ((float)idx / (float)[[toVC transactionCells] count]) * MAX_DELAY;
            [self presentView:obj withDelay:delay andDelta:delta];
        }];
    } else {
        [self presentView:self.viewCopyForNew withDelay:0 andDelta:delta];
    }
    
    // 最后将第二个页面添加替换添加第二个页面的View的原页面.
    NSArray *controllerList = [NSArray arrayWithObjects:fromVC, toVC, nil];
    [self performSelector:@selector(showSecondVC:) withObject:controllerList afterDelay:MAX_DELAY + DURATION];
    
    return YES;
}

- (void)showSecondVC:(NSArray *)controllerList {
    UIViewController *firstVC = (UIViewController *)[controllerList objectAtIndex:0];
    UIViewController *secondVC = (UIViewController *)[controllerList objectAtIndex:1];
    [self.viewCopyForNew removeFromSuperview];
    if (self.operation == UINavigationControllerOperationPush) {
        [firstVC.navigationController pushViewController:secondVC animated:NO];
    } else {
        [firstVC.navigationController popViewControllerAnimated:NO];
    }
}

- (void)hideView:(UIView *)view withDelay:(NSTimeInterval)delay andDelta:(float)delta {
    void (^animation)() = ^{
        [view setTransform:CGAffineTransformMakeTranslation(delta, 0)];
        [view setAlpha:0];
    };
    void (^completion)(BOOL) = ^(BOOL finished){
        [view setTransform:CGAffineTransformIdentity];
    };
    [UIView animateWithDuration:DURATION delay:delay options:UIViewAnimationOptionCurveEaseIn animations:animation completion:completion];
}


- (void)presentView:(UIView *)view withDelay:(NSTimeInterval)delay andDelta:(float)delta {
    [view setTransform:CGAffineTransformMakeTranslation(delta, 0)];
    void (^animation)() = ^{
        [view setTransform:CGAffineTransformIdentity];
        [view setAlpha:1];
    };
    void (^completion)(BOOL) = ^(BOOL finished) {
    };
    
    [UIView animateWithDuration:DURATION delay:delay options:UIViewAnimationOptionCurveEaseIn animations:animation completion:completion];
    
}

BOOL RequireSysVerGreaterOrEqual(NSString *reqSysVer) {
    BOOL ret = NO;
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending) {
        ret = YES;
    }
    return ret;
}

@end
