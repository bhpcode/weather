//
//  CollectionCellParallaxable.h
//  weather
//
//  Created by Matthew Connor on 10/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CollectionCellParallaxable <NSObject>
- (void) updateCellParallax: (CGPoint) scrollOffset scrollViewBoundSize: (CGSize) size;
@end
