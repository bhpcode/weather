//
//  AppDelegate.m
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()
@property(nonatomic,strong)WeatherManager* implWeatherManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    _implWeatherManager = [WeatherManager new];
    return YES;
}

+ (WeatherManager*) weatherManager
{
    AppDelegate* ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return ad.implWeatherManager;
}

@end
