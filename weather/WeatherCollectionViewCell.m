//
//  WeatherCollectionViewCell.m
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherCollectionViewCell.h"
#import "WeatherData.h"
#import "UIImage+GIF.h"
#import "AppDelegate.h"
#import "WeatherManager.h"
#import "WeatherImageManager.h"


@interface WeatherCollectionViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageCentreYConstraint;
@property (nonatomic,weak) UIButton* deletionButton;
@end

@implementation WeatherCollectionViewCell
@synthesize isDeleting = _impIsDeleting;

- (void) awakeFromNib
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6;
    self.imageContainerView.layer.masksToBounds = YES;
    self.imageContainerView.layer.cornerRadius = 6;
}

- (void) setIsDeleting:(BOOL)isDeleting
{
    if (_impIsDeleting != isDeleting){
        
        _impIsDeleting = isDeleting;
        
        [self isDeletingDidSet: isDeleting];
    }
    
}

- (BOOL) isDeleting
{
    return _impIsDeleting;
}

- (void) updateWithData: (WeatherData*) data
{
    self.cityLabel.text = data.city;
    self.tempLabel.text = (data.temp < -273.0) ? @"--":[NSString stringWithFormat: @"%.0f\u00B0", data.temp];
    
    self.imageView.alpha = 0.5;
    
    WeatherCondition* weather = [data anyWeatherCondition];
    
    if (weather.longDescription)
        self.windLabel.text = weather.longDescription;
    else
        self.windLabel.text = @"";
    
    
    WeatherManager* manager = [AppDelegate weatherManager];
    UIImage* largeIcon = [manager.imageManager largeIconForWeatherID:[data weatherId]];
    
    self.imageView.image = largeIcon;
    
    
}

#pragma mark - CollectionCellParallaxable

- (void) updateCellParallax: (CGPoint) scrollOffset scrollViewBoundSize: (CGSize) size
{
    CGFloat dy = 100 * scrollOffset.y / size.height;
    if (dy > 50) dy = 50;
    if (dy < -50) dy = -50;
    self.imageCentreYConstraint.constant = dy;
}

#pragma mark - private

- (void) isDeletingDidSet: (BOOL)newValue
{
    if (newValue){
        UIButton* db = [UIButton buttonWithType:UIButtonTypeSystem];
        [db setTitle:@"X" forState:UIControlStateNormal];
        [db setBackgroundColor:[UIColor grayColor]];
        [db setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
        db.frame = CGRectMake(-4, -4, 32, 32);
        db.layer.cornerRadius = 16;
        
        [db addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:db];
        self.contentView.superview.clipsToBounds = NO;
        
        self.deletionButton = db;
        
        
    }else{
        [self.deletionButton removeFromSuperview];
    }
    
    
}

#pragma mark - button event

- (void) deleteButtonPressed:(UIButton*)button
{
    [self.deleteDelegate cellDeletePressed:self];
}

@end


@implementation AddCityCollectionViewCell

@end



