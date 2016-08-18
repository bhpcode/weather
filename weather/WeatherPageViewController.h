//
//  WeatherPageViewController.h
//  weather
//
//  Created by Matthew Connor on 11/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherManager;

@interface WeatherPageViewController : UIViewController
@property (nonatomic,strong) WeatherManager* manager;
@property (nonatomic, assign) NSInteger currentIndex;
@end
