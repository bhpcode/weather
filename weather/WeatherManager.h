//
//  WeatherManager.h
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherManager;
@class WeatherData;
@class WeatherImageManager;

@protocol  WeatherManagerDelegate <NSObject>
- (void) weatherManager: (WeatherManager*) manager didUpdateData: (WeatherData*) data atIndex: (NSUInteger)index;
@end

@interface WeatherManager : NSObject

@property (assign,nonatomic) NSTimeInterval updateTime;
@property (nonatomic, readonly) NSOrderedSet* cities;
@property (weak, nonatomic) id<WeatherManagerDelegate> delegate;
@property (strong, nonatomic) WeatherImageManager* imageManager;

- (NSUInteger) addCity: (NSString*) name;
- (void) removeCityAtIndex: (NSUInteger) index;
- (void) removeCity: (NSString*)name;
- (void) updateCity: (NSString*)name;

@end
