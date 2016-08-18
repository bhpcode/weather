//
//  WeatherViewController+CellDeletion.h
//  weather
//
//  Created by Matthew Connor on 08/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherViewController.h"
#import "CollectionViewCellDeletable.h"

@interface WeatherViewController (CellDeletion)<UIGestureRecognizerDelegate,CollectionViewCellDelegate>

- (void) setupCellDeletion;

@end
