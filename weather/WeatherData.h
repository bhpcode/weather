//
//  WeatherData.h
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherCondition : NSObject
@property (nonatomic,readonly) NSString* uid;
@property (nonatomic,readonly) NSString* longDescription;
@property (nonatomic,readonly) NSString* shortDescription;
+(instancetype) createWithJSONDictionary: (NSDictionary*)dict;
@end

@interface WeatherData : NSObject

@property (nonatomic, strong, readonly) NSString* city;

@property (nonatomic, readonly) double lat;
@property (nonatomic, readonly) double lon;

@property (nonatomic, readonly) double temp;
@property (nonatomic, readonly) double tempMin;
@property (nonatomic, readonly) double tempMax;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double humidity;

@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) double windDirection;
@property (nonatomic, readonly) double windGust;

@property (nonatomic, readonly) double cloudCover;

@property (nonatomic, readonly) NSString* cityDescription;
@property (nonatomic, readonly) NSTimeInterval sunrise;
@property (nonatomic, readonly) NSTimeInterval sunset;

@property (nonatomic, readonly) NSArray* weather;

+(instancetype) createWithCityName: (NSString*)city;
+(instancetype) createWithJSONDictionary: (NSDictionary*)dict;
-(void)updateCity:(NSString*)city;

-(WeatherCondition*)anyWeatherCondition;

-(NSString*)tempToString:(double)temp;
-(NSString*)kmhToString:(double)speed;
-(NSString*)degreesToString:(double)degrees;
-(NSString*)timeToString:(NSTimeInterval)time;
-(NSString*)pressureToString;
-(NSString*)humidityToString;
-(NSString*)weatherDescriptionString;
-(NSString*)weatherId;

@end
