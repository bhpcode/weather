//
//  WeatherData.m
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherData.h"

static double DoubleFromDictValue(id value)
{
    if ([value respondsToSelector:@selector(doubleValue)]){
        return [value doubleValue];
    }
    return 0;
}

@implementation WeatherData

+(instancetype) createWithCityName: (NSString*)city
{
    return [[WeatherData alloc] initWithCityName:city];
}

+(instancetype) createWithJSONDictionary: (NSDictionary*)dict
{
    return [[WeatherData alloc] initWithJSONDictionary:dict];
}

- (id) initWithCityName: (NSString*)city
{
    if (self = [super init]){
        _city = city;
    }
    return self;
}

- (id) initWithJSONDictionary: (NSDictionary*)dict
{
    const double kDegreesToKelvin = 273.16;
    
    if (self = [super init]){
        
        _lat = DoubleFromDictValue(dict[@"coord"][@"lat"]);
        _lon = DoubleFromDictValue(dict[@"coord"][@"lon"]);
        
        _temp = DoubleFromDictValue(dict[@"main"][@"temp"]);
        _temp -= kDegreesToKelvin;
        
        _pressure = DoubleFromDictValue(dict[@"main"][@"pressure"]);
        _humidity = DoubleFromDictValue(dict[@"main"][@"humidity"]);
        
        _tempMin = DoubleFromDictValue(dict[@"main"][@"temp_min"]);
        _tempMin -= kDegreesToKelvin;
        
        _tempMax = DoubleFromDictValue(dict[@"main"][@"temp_max"]);
        _tempMax -= kDegreesToKelvin;
        
        _windSpeed = DoubleFromDictValue(dict[@"wind"][@"speed"]);
        _windDirection = DoubleFromDictValue(dict[@"wind"][@"deg"]);
        _windGust = DoubleFromDictValue(dict[@"wind"][@"gust"]);
        
        _cloudCover = DoubleFromDictValue(dict[@"clouds"][@"all"]);
        _cityDescription = dict[@"name"];
        _sunrise = DoubleFromDictValue(dict[@"sys"][@"sunrise"]);
        _sunset = DoubleFromDictValue(dict[@"sys"][@"sunset"]);
        
        NSMutableArray* tmpWeather = [NSMutableArray new];
        
        NSArray* weather = dict[@"weather"];
        for (NSDictionary* dict in weather) {
            WeatherCondition* condition = [WeatherCondition createWithJSONDictionary:dict];
            if (condition)
                [tmpWeather addObject:condition];
        }
        
        if (tmpWeather.count)
            _weather = tmpWeather;
        
    }
    return self;
}

- (NSString*) debugDescription
{
    return [NSString stringWithFormat:@"<self=0x%.8x> city=%@ lat=%.3f lon=%.3f\n"
                                "temp=%.2f pressure=%.2f humidity=%.2f\n"
                                "tempMin=%.2f tempMax=%.2f windSpeed=%.2f windDirection=%.2f windGust=%.2f\n"
                                "cloudCover=%.2f cityDescription=%@ sunrise=%.2f sunset=%.2f",
     
     (uint32_t)self,
     _city, //ss
    _lat,
    _lon,
    _temp,
    
     _pressure,
    _humidity,
    _tempMin,
    _tempMax,
    
    _windSpeed,
    _windDirection,
    _windGust,
    
    _cloudCover,
    _cityDescription, //ss
    _sunrise,
     _sunset];
    
}

-(void)updateCity:(NSString*)city
{
    _city =city;
}

-(WeatherCondition*)anyWeatherCondition
{
    return self.weather.count ? self.weather.firstObject : nil;
}

-(NSString*)tempToString:(double)temp
{
    return temp < -273.0 ? @"--":[NSString stringWithFormat: @"%.0f\u00B0", temp];
}

-(NSString*)kmhToString:(double)speed
{
    return [NSString stringWithFormat: @"%.0f km/h", speed];
}

-(NSString*)degreesToString:(double)degrees
{
    return [NSString stringWithFormat: @"%.0f\u00B0", degrees];
}

-(NSString*)timeToString:(NSTimeInterval)time
{
    NSDateFormatter* df = [NSDateFormatter new];
    df.dateFormat = @"HH:mm:ss";
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
    return date != nil?[df stringFromDate: date]:@"--:--:--";
}

-(NSString*)pressureToString
{
    return [NSString stringWithFormat: @"%.0fhPa", self.pressure];
}

-(NSString*)humidityToString
{
    return [NSString stringWithFormat: @"%.0f%%", self.humidity];
}

-(NSString*)weatherDescriptionString
{
    if (self.weather.count){
        WeatherCondition* condition = [self.weather objectAtIndex:0];
        return condition.longDescription;
    }
    return nil;
}

-(NSString*)weatherId
{
    if (self.weather.count){
        WeatherCondition* condition = [self.weather objectAtIndex:0];
        return condition.uid;
    }
    return nil;
}

#pragma mark - NSSet equality stuff

- (BOOL) isEqual:(id)object
{
    if ([object isKindOfClass:[WeatherData class]])
        return [((WeatherData*) object).city isEqualToString:self.city];
    return NO;
}

- (NSUInteger) hash
{
    return [self.city hash];
}

@end


@implementation WeatherCondition

+(instancetype) createWithJSONDictionary: (NSDictionary*)dict
{
    return  [[WeatherCondition alloc] initWithJSONDictionary:dict];
}

-(id) initWithJSONDictionary: (NSDictionary*)dict
{
    if (self = [super init]){
        
        _shortDescription = dict[@"main"];
        _longDescription = dict[@"description"];
        _uid = [dict[@"id"] stringValue];
        
    }
    return self;
}
@end

