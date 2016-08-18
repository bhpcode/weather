//
//  AddCityViewController.h
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CityAddCallback)();

@interface AddCityViewController : UIViewController
@property (nonatomic,strong) CityAddCallback callback;
@end
