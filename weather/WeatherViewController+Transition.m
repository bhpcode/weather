//
//  WeatherViewController+Transition.m
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherViewController+Transition.h"
#import "WeatherDetailViewController.h"

#import "WeatherShowDetailAnimateController.h"
#import "WeatherDismissDetailAnimateController.h"

#import "AddCityViewController.h"
#import "WeatherPageViewController.h"

#import "WeatherManager.h"

@implementation WeatherViewController (Transition)

- (void) showDetailWithCellAtIndexPath:(NSIndexPath*)indexPath
{
    UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell == nil)
        return;
 
    self.selectedIndexPath = indexPath;
    
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect cellRect = attributes.frame;
    CGRect cellFrameInSuperview = [self.collectionView convertRect:cellRect toView:[self.collectionView superview]];
    
    self.showDetailAnimateController.originalView = self.view;
    self.showDetailAnimateController.originalFrame = cellFrameInSuperview;
    
    self.dismissDetailAnimateController.targetFrame = cellFrameInSuperview;
    
    [self performSegueWithIdentifier:@"showWeatherDetail" sender:nil];
}

#pragma mark - Segue override

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showWeatherDetail"]){
        
        WeatherDetailViewController* detailVC = (WeatherDetailViewController*)segue.destinationViewController;
        detailVC.weatherData = [self.manager.cities objectAtIndex:self.selectedIndexPath.row];
        detailVC.transitioningDelegate = self;
        
    }else if ([segue.identifier isEqualToString:@"showPageViewController"]){
        
        WeatherPageViewController* weatherPageVC = (WeatherPageViewController*)segue.destinationViewController;
        weatherPageVC.currentIndex = self.selectedIndexPath.row;
        weatherPageVC.manager = self.manager;
        
    }else{
        AddCityViewController* addCityVC = (AddCityViewController*)segue.destinationViewController;
        addCityVC.callback = ^{
            [self.collectionView reloadData];
        };
    }
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    return self.showDetailAnimateController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissDetailAnimateController;
}

@end
