//
//  WeatherCollectionViewCell.h
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCellDeletable.h"
#import "CollectionCellParallaxable.h"

@class WeatherData;

@interface WeatherCollectionViewCell : UICollectionViewCell<CollectionViewCellDeletable, CollectionCellParallaxable>

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;

@property (weak, nonatomic) id<CollectionViewCellDelegate> deleteDelegate;

- (void) updateWithData: (WeatherData*) data;

@end


@interface AddCityCollectionViewCell : UICollectionViewCell

@end


