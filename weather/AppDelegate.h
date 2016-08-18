//
//  AppDelegate.h
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherManager.h"

@interface AppDelegate : NSObject<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (WeatherManager*) weatherManager;

@end
