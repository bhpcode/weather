//
//  DefaultCellDeleteAnimationStrategy.m
//  weather
//
//  Created by Matthew Connor on 08/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "DefaultCellDeleteAnimationStrategy.h"
#import <UIKit/UIKit.h>

#define degreesToRadians(x) (M_PI * (x) / 180.0)

@implementation DefaultCellDeleteAnimationStrategy

- (void) setCellDeleting: (UICollectionViewCell*)cell atIndex: (NSUInteger)index
{
    const CGFloat kAnimationRotateDeg=0.5f;
    const CGFloat kAnimationTranslateX=1.f;
    const CGFloat kAnimationTranslateY=1.f;
    const NSTimeInterval kPerCellAnimationDelay = 0.08;
    
    CGFloat leftDirection = (index&1) ? 1:-1;
    CGFloat rightDirection = (index&1) ? -1:1;
    
    CGAffineTransform leftWobble = CGAffineTransformMakeRotation(degreesToRadians( kAnimationRotateDeg * leftDirection ));
    CGAffineTransform rightWobble = CGAffineTransformMakeRotation(degreesToRadians( kAnimationRotateDeg * rightDirection ));
    CGAffineTransform moveTransform = CGAffineTransformTranslate(rightWobble, -kAnimationTranslateX, -kAnimationTranslateY);
    CGAffineTransform conCatTransform = CGAffineTransformConcat(rightWobble, moveTransform);
    
    cell.transform = leftWobble;  // starting point
    
    [UIView animateWithDuration:0.075
                          delay:(index * kPerCellAnimationDelay)
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{ cell.transform = conCatTransform; }
                     completion:nil];
}

- (void) resetCellDeleting: (UICollectionViewCell*)cell
{
    [UIView animateWithDuration:0.05
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{ cell.transform = CGAffineTransformIdentity; }
                     completion:nil];
}

@end