//
//  CollectionViewCellDeletable.h
//  weather
//
//  Created by Matthew Connor on 08/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol CollectionViewCellDeletable <NSObject>
@property (nonatomic, assign) BOOL isDeleting;
@end

@protocol CollectionViewCellDelegate <NSObject>
- (void) cellDeletePressed: (UICollectionViewCell*) cell;
@end