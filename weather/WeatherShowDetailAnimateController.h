//
//  WeatherShowDetailAnimateController.h
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherShowDetailAnimateController : NSObject<UIViewControllerAnimatedTransitioning>
@property(assign,nonatomic) CGRect originalFrame;
@property(weak,nonatomic) UIView* originalView;
@end

extern CGRect CreateZoomRect(CGRect zoomArea, CGRect inRect);