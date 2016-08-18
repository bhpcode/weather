//
//  WeatherShowDetailAnimateController.m
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherShowDetailAnimateController.h"

@implementation WeatherShowDetailAnimateController

CGRect CreateZoomRect(CGRect zoomArea, CGRect inRect)
{
    CGFloat wR = inRect.size.width / zoomArea.size.width;
    CGFloat hR = inRect.size.height / zoomArea.size.height;
    
    CGFloat tX = -wR * zoomArea.origin.x;
    CGFloat tY = -hR * zoomArea.origin.y;
    CGFloat tW = inRect.size.width * wR;
    CGFloat tH = inRect.size.height * hR;
    
    return CGRectMake(tX, tY, tW, tH);
    
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kWeatherDetailTransitionDuration;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    
    if (fromVC == nil || toVC == nil || containerView == nil)
        return;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView* fromSnapshotView = [self.originalView snapshotViewAfterScreenUpdates:YES];
    UIView* toSnapshotView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    CGRect targetFrame = [transitionContext finalFrameForViewController:toVC];
    
    [containerView addSubview:fromSnapshotView];
    [containerView addSubview:toSnapshotView];
    [containerView addSubview:toVC.view];
    
    CGRect zoomFrame = CreateZoomRect(self.originalFrame,fromVC.view.frame);
    
    toSnapshotView.frame = self.originalFrame;
    toSnapshotView.alpha = 0.0;
    toVC.view.alpha = 0.0;
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:2.0/3.0 animations:^{
            fromSnapshotView.frame = zoomFrame;
            toSnapshotView.frame= targetFrame;
            toSnapshotView.alpha = 0.67;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2.0/3.0 relativeDuration:1.0/3.0 animations:^{
            toVC.view.alpha = 1.0;
        }];
        
    } completion:^(BOOL finished) {
    
        [fromSnapshotView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
}

@end
