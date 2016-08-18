//
//  ViewController.m
//  weather
//
//  Created by Matthew Connor on 05/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherCollectionViewCell.h"
#import "WeatherManager.h"
#import "WeatherData.h"
#import "AppDelegate.h"
#import "WeatherViewController+CellDeletion.h"
#import "DefaultCellDeleteAnimationStrategy.h"
#import "WeatherDetailViewController.h"

#import "WeatherShowDetailAnimateController.h"
#import "WeatherDismissDetailAnimateController.h"

#import "WeatherViewController+Transition.h"

const NSTimeInterval kWeatherDetailTransitionDuration = 0.7;
const UIEdgeInsets kDefaultInsets = {8,8,8,8};
const CGFloat kInterCellSpacing = 8.f;

@interface WeatherViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, WeatherManagerDelegate>
@end

@implementation WeatherViewController

- (WeatherManager*) manager
{
    return [AppDelegate weatherManager];
}

#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager.delegate = self;
    [self setupCellDeletion];
    
    self.showDetailAnimateController = [WeatherShowDetailAnimateController new];
    self.dismissDetailAnimateController = [WeatherDismissDetailAnimateController new];

    [self updateFlowLayoutItemSize:self.view.bounds.size];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UIEdgeInsets) collectionView: (UICollectionView*)collectionView
                        layout:(nonnull UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex: (NSInteger) section
{
    return kDefaultInsets;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.manager.cities.count + 1;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    
    if (index == self.manager.cities.count){
        AddCityCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddCityCollectionViewCell" forIndexPath:indexPath];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 6;
        return cell;
    } else {
        WeatherCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCollectionViewCell" forIndexPath:indexPath];
        WeatherData* data = [self.manager.cities objectAtIndex:index];
        
        [cell updateWithData: data];
        [cell updateCellParallax: self.collectionView.contentOffset scrollViewBoundSize:self.collectionView.frame.size];
        
        cell.deleteDelegate = self;
        cell.isDeleting = self.deleting;
        
        return cell;
    }
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.manager.cities.count){
        self.selectedIndexPath  = indexPath;
        [self performSegueWithIdentifier:@"showPageViewController" sender:nil];
    }else{
        [self showAddCityViewController];
    }
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (UICollectionViewCell* cell in self.collectionView.visibleCells){
        if ([cell conformsToProtocol:@protocol(CollectionCellParallaxable)]){
            [ (id<CollectionCellParallaxable>) cell updateCellParallax: scrollView.contentOffset scrollViewBoundSize:self.collectionView.frame.size];
        }
    }
}

#pragma mark - WeatherManagerDelegate

- (void) weatherManager:(WeatherManager *)manager didUpdateData:(WeatherData *)data atIndex:(NSUInteger)index
{
    NSIndexPath* ipath = [NSIndexPath indexPathForRow:index inSection:0];
    WeatherCollectionViewCell* cell = (WeatherCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:ipath];
    [cell updateWithData: data];
    
}

#pragma mark - show add city

- (void) showAddCityViewController
{
    [self performSegueWithIdentifier:@"showAddCityViewController" sender:nil];
}

#pragma mark - layout management

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self updateFlowLayoutItemSize:size];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

-(void) updateFlowLayoutItemSize: (CGSize)size
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    CGFloat w = size.width - (kDefaultInsets.left + kDefaultInsets.right);
    CGFloat estimatedPerRow = w / 200.0f;
    
    if (estimatedPerRow > 3.f) {
        estimatedPerRow = 3;
    }else{
        estimatedPerRow = 2;
    }
    
    CGFloat itemW = (CGFloat) ((NSInteger) ( (w - kInterCellSpacing * (estimatedPerRow-1)) / estimatedPerRow) ) - 1;
    flowLayout.itemSize = CGSizeMake(itemW, 200.0);

}

@end
