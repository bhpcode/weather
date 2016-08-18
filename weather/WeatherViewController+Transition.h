//
//  WeatherViewController+Transition.h
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"

@interface WeatherViewController (Transition)<UIViewControllerTransitioningDelegate>
-(void) showDetailWithCellAtIndexPath:(NSIndexPath*)indexPath;
@end
