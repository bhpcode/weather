//
//  WeatherDetailViewController.h
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeatherData;

@interface WeatherDetailViewController : UIViewController

@property (nonatomic,strong) WeatherData* weatherData;

@end
