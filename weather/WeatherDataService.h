//
//  WeatherDataService.h
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherData;

typedef void (^WeatherDataServiceCallback)(WeatherData*,NSError*);

@interface WeatherDataService : NSObject

- (void) updateCity: (NSString*) city callback: (WeatherDataServiceCallback)callback;
- (void) cancelUpdateCity: (NSString*) city;

@end
