//
//  WeatherDismissDetailAnimateController.h
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDismissDetailAnimateController : NSObject<UIViewControllerAnimatedTransitioning>
@property(assign,nonatomic) CGRect targetFrame;
@end
