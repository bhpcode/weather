//
//  CellDeleteAnimationStrategy.h
//  weather
//
//  Created by Matthew Connor on 08/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UICollectionViewCell;

@protocol CellDeleteAnimationStrategy <NSObject>

- (void) setCellDeleting: (UICollectionViewCell*)cell atIndex: (NSUInteger)index;
- (void) resetCellDeleting: (UICollectionViewCell*)cell;

@end
