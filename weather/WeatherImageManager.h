//
//  WeatherImageManager.h
//  weather
//
//  Created by Matthew Connor on 10/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherImageManager : NSObject

- (UIImage*) gifForWeatherID: (NSString*) uid;
- (UIImage*) iconForWeatherID: (NSString*) uid;
- (UIImage*) largeIconForWeatherID: (NSString*) uid;

- (id) initWithJSONFile: (NSString*) name;

@end
