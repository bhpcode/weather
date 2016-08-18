//
//  WeatherManager.m
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherManager.h"
#import "WeatherData.h"
#import "WeatherDataService.h"
#import "WeatherImageManager.h"

@interface WeatherManager()
@property(nonatomic,strong) NSMutableOrderedSet* implCities;
@property (nonatomic,strong) WeatherDataService* service;
@property (nonatomic,strong) NSTimer* updateTimer;

@end


@implementation WeatherManager

- (void) setDelegate:(id<WeatherManagerDelegate>)delegate
{
    if (_delegate != delegate){
        _delegate = delegate;
        if (_delegate){
            [self startUpdateTimer];
            [self updateTimer:nil];
        }
    }
}

- (NSOrderedSet*) cities
{
    return self.implCities;
}

- (id)init
{
    if (self = [super init]){
        
        NSArray* cities = [[NSUserDefaults standardUserDefaults] objectForKey:@"cities"];
        _implCities = [NSMutableOrderedSet new];
        for (NSString * city in cities){
            [self addCity:city];
        }
        self.service = [WeatherDataService new];
        _imageManager = [[WeatherImageManager alloc] initWithJSONFile:@"icons"];
        
        
    }
    return self;
}

- (void) startUpdateTimer
{
    [self stopUpdateTimer];
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

- (void) stopUpdateTimer
{
    
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (NSUInteger) addCity: (NSString*) name
{
    WeatherData * newData = [WeatherData createWithCityName: name];
    NSUInteger index = [self.implCities indexOfObject:newData];
    
    if (index == NSNotFound){
        [self.implCities addObject:newData];
        index = [self.implCities indexOfObject:newData];
        [self updateCity:name];
        [self updateStore];
    }
    return index;
}

- (void) removeCityAtIndex: (NSUInteger) index
{
    if (index != NSNotFound){
        [self.implCities removeObjectAtIndex:index];
        [self updateStore];
    }
}

- (void) removeCity: (NSString*)name
{
    NSUInteger index = [self.implCities indexOfObject:[WeatherData createWithCityName: name]];
    
    if (index != NSNotFound){
        [self.implCities removeObjectAtIndex:index];
        [self updateStore];
    }
}

- (void) updateCity: (NSString*)name
{
    NSUInteger index = [self.implCities indexOfObject:[WeatherData createWithCityName: name]];
    
    if (index == NSNotFound)
        index = [self addCity:name];
    
    __weak __typeof(self) weakSelf = self;
    
    [self.service updateCity:name callback:^(WeatherData *data, NSError *error) {
       
        if (data){
           
             __strong __typeof(self) strongSelf = weakSelf;
            
            if (strongSelf){

                NSUInteger index = [strongSelf.implCities indexOfObject:data];
                [strongSelf.implCities replaceObjectAtIndex:index withObject:data];
                [strongSelf.delegate weatherManager:strongSelf didUpdateData:data atIndex:index];
            }
        }
        
    }];
}

#pragma mark - private

- (void) updateStore
{
    NSMutableArray* cities = [NSMutableArray new];
    for (WeatherData* data in self.implCities){
        [cities addObject:data.city];
    }
    [[NSUserDefaults standardUserDefaults] setObject: cities forKey:@"cities"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) updateTimer: (NSTimer*)timer
{
    for (WeatherData* data in self.implCities)
        [self updateCity:data.city];
}

@end

