//
//  WeatherImageManager.m
//  weather
//
//  Created by Matthew Connor on 10/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherImageManager.h"
#import "UIImage+GIF.h"

@interface WeatherUIDIcon : NSObject
@property(nonatomic,assign) NSInteger startUID;
@property(nonatomic,assign) NSInteger endUID;
@property(nonatomic,strong) NSString* iconName;
@property(nonatomic,strong) NSString* gifName;
@end

@implementation WeatherUIDIcon
@end

@interface WeatherImageManager()
@property (nonatomic,strong) NSMutableArray* weatherUIDIcons;
@end

@implementation WeatherImageManager

- (id) initWithJSONFile: (NSString*) name
{
    if (self = [super init]){
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
        
        NSData* jsonData = [NSData dataWithContentsOfFile:filePath];
        NSError* error = nil;
        
        id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        if ([object isKindOfClass:[NSArray class]]){
            
            _weatherUIDIcons = [NSMutableArray new];
            
            for (NSDictionary* dict in object){
                
                WeatherUIDIcon * icon = [WeatherUIDIcon new];
                
                icon.startUID = [dict[@"startUID"] integerValue];
                icon.endUID = [dict[@"endUID"] integerValue];
                icon.iconName = dict[@"icon"];
                icon.gifName = dict[@"gif"];
                
                [_weatherUIDIcons addObject:icon];
            }
        }
        
    }
    return self;
}

- (WeatherUIDIcon*) iconFromUID: (NSString*) uid
{
    if (self.weatherUIDIcons.count == 0)
        return nil;
    
    NSInteger iuid = [uid integerValue];
    if (iuid < [self.weatherUIDIcons.firstObject startUID])
        return nil;
    
    for (WeatherUIDIcon* icon in self.weatherUIDIcons){
        if (iuid >= icon.startUID && iuid <= icon.endUID)
            return icon;
    }
    return nil;
}

- (UIImage*) iconForWeatherID: (NSString*) uid
{
    WeatherUIDIcon* icon = [self iconFromUID:uid];
    return [UIImage imageNamed:icon.iconName];
}

- (UIImage*) largeIconForWeatherID: (NSString*) uid
{
    WeatherUIDIcon* icon = [self iconFromUID:uid];
    NSString *file = [NSString stringWithFormat:@"%@-large",icon.iconName];
    UIImage* image = [UIImage imageNamed:file];
    return image;
}

- (UIImage*) gifForWeatherID: (NSString*) uid
{
    WeatherUIDIcon* icon = [self iconFromUID:uid];
    return [UIImage imageNamed:icon.gifName];
}

@end
