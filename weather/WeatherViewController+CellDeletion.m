//
//  WeatherViewController+CellDeletion.m
//  weather
//
//  Created by Matthew Connor on 08/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherViewController+CellDeletion.h"
#import "DefaultCellDeleteAnimationStrategy.h"
#import "CollectionViewCellDeletable.h"
#import "WeatherManager.h"

@implementation WeatherViewController (CellDeletion)

- (void) setupCellDeletion
{
    self.cellDeleteAnimationStrategy = [DefaultCellDeleteAnimationStrategy new];
    
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    gestureRecognizer.delegate = self;
    gestureRecognizer.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:gestureRecognizer];
   
}

- (void) handleLongPress: (UILongPressGestureRecognizer*) gestureRecognizer
{
    if (self.deleting)
        return;
    
    self.deleting = YES;
    [self beginCellDeleting];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.delegate = self;
    tapGestureRecognizer.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void) handleTap: (UITapGestureRecognizer*) gestureRecognizer
{
    if (!self.deleting)
        return;
    
    self.deleting = NO;
    [self endCellDeleting];
    
    [self.collectionView removeGestureRecognizer:gestureRecognizer];
    
}

- (void) beginCellDeleting
{
    int index = 1;
    
    for (UICollectionViewCell* cell in self.collectionView.visibleCells){
    
        if ([cell conformsToProtocol:@protocol(CollectionViewCellDeletable)]){
            [self.cellDeleteAnimationStrategy setCellDeleting: cell atIndex: index];
            ((id<CollectionViewCellDeletable>) cell).isDeleting = YES;
            ++index;
        }
    }
}

- (void) endCellDeleting
{
    for (UICollectionViewCell* cell in self.collectionView.visibleCells){
        
        if ([cell conformsToProtocol:@protocol(CollectionViewCellDeletable)]){
            [self.cellDeleteAnimationStrategy resetCellDeleting: cell];
            ((id<CollectionViewCellDeletable>) cell).isDeleting = NO;
        }
        
    }
}

#pragma mark - CollectionViewCellDelegate 

- (void) cellDeletePressed:(UICollectionViewCell *)cell
{
    NSIndexPath* ip = [self.collectionView indexPathForCell:cell];
    if (ip == nil)
        return;
    
    __weak __typeof(self) weakSelf = self;
    
    [self.collectionView performBatchUpdates:^{
        
        __strong __typeof(self) strongSelf = weakSelf;
        
        if (strongSelf){
            [strongSelf.manager removeCityAtIndex:ip.row];
            [strongSelf.collectionView deleteItemsAtIndexPaths:@[ip]];
        }
        
    } completion:^(BOOL finished) {
        
        __strong __typeof(self) strongSelf = weakSelf;
        
        if (strongSelf){
        
            if (strongSelf.deleting){
                
                [strongSelf beginCellDeleting];
            
            }
            
        }
        
    }];
    
    
}

@end