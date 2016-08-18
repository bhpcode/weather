//
//  WeatherDismissDetailAnimateController.m
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherDismissDetailAnimateController.h"
#import "WeatherShowDetailAnimateController.h"

@implementation WeatherDismissDetailAnimateController

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
    
    UIView* fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates: YES];
    UIView* toSnapshot = [toVC.view snapshotViewAfterScreenUpdates: YES];
    
    fromSnapshot.frame = fromVC.view.frame;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:toSnapshot];
    [containerView addSubview:fromSnapshot];
    
    toVC.view.alpha = 1.0;
    toSnapshot.frame = CreateZoomRect(self.targetFrame, toVC.view.frame);
    
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:2.0/3.0 animations:^{
                                      fromSnapshot.frame = self.targetFrame;
                                      fromSnapshot.alpha = 0.5;
                                      toSnapshot.frame = toVC.view.frame;
                                      
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:2.0/3.0 relativeDuration:1.0/3.0 animations:^{
                                      toVC.view.alpha = 1.0;
                                      fromSnapshot.alpha = 0.0;
                                      
                                  }];
                                  
                              }
     
                              completion:^(BOOL finished){
                                  
                                  [fromSnapshot removeFromSuperview];
                                  [toSnapshot removeFromSuperview];
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                                  
                              }];
    
    
}


@end