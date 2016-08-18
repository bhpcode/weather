//
//  WeatherDataService.m
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherDataService.h"
#import "WeatherData.h"

@interface WeatherDataService()
@property (nonatomic,strong) NSURLSession* session;
@property (nonatomic,strong) NSMutableDictionary* taskManager;
@end

@implementation WeatherDataService

- (id) init
{
    if (self = [super init]){
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.taskManager = [NSMutableDictionary new];
    }
    return self;
}

- (void) updateCity: (NSString*) city callback: (WeatherDataServiceCallback)callback
{
    NSAssert(callback != nil, @"callback must not be nil");
    
    NSString* urlString = [NSString stringWithFormat: @"http://api.openweathermap.org/data/2.5/weather?q=%@,&appid=bdadf98884a2e23543e7a1198bffa2fa", city];
    NSURL* url = [NSURL URLWithString:urlString];
    
    __weak __typeof(self) weakSelf = self;
    
    NSURLSessionDataTask* task = [self.session dataTaskWithURL:url
                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        [weakSelf updateFromData: data city: city withError:error callback:callback];
        
    }];
    
    [self.taskManager setValue:task forKey:city];
    [task resume];
    
}

- (void) cancelUpdateCity: (NSString*) city
{
    NSURLSessionDataTask* task = [self.taskManager objectForKey:city];
    [task cancel];
    [self.taskManager removeObjectForKey:city];
}

- (void) updateFromData: (NSData*)data city: (NSString*) city withError: (NSError*) error callback: (WeatherDataServiceCallback)callback
{
    WeatherData* newData = nil;
    
    if (!error){

        id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (!error){
        
            newData = [WeatherData createWithJSONDictionary:dict];
            if (newData){
                [newData updateCity: city];
            }else{
                error = [NSError errorWithDomain:@"Weather Dictionary invalid" code:0 userInfo:nil];
            }
            
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.taskManager removeObjectForKey:city];
        callback(newData,error);
        
    });
}

@end
