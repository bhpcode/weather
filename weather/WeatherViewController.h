//
//  ViewController.h
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WobbleCellManager;
@class WeatherManager;
@protocol CellDeleteAnimationStrategy;


@class WeatherShowDetailAnimateController;
@class WeatherDismissDetailAnimateController;

extern const NSTimeInterval kWeatherDetailTransitionDuration;

@interface WeatherViewController : UIViewController

@property (nonatomic,readonly) WeatherManager* manager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) BOOL deleting;
@property (nonatomic, strong) id<CellDeleteAnimationStrategy> cellDeleteAnimationStrategy;

@property (nonatomic,strong) WeatherShowDetailAnimateController *showDetailAnimateController;
@property (nonatomic,strong) WeatherDismissDetailAnimateController *dismissDetailAnimateController;

@property (nonatomic, strong) NSIndexPath* selectedIndexPath;

@end
