//
//  UIViewController+Indexable.m
//  weather
//
//  Created by Matthew Connor on 12/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "UIViewController+Indexable.h"
#import <objc/runtime.h>

@implementation UIViewController (Indexable)

@dynamic index;

- (void)setIndex:(NSUInteger)index
{
    NSNumber* indexNumber = [NSNumber numberWithInteger:index];
    objc_setAssociatedObject(self, @selector(index), indexNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)index
{
    NSNumber* indexNumber = objc_getAssociatedObject(self, @selector(index));
    return [indexNumber unsignedIntegerValue];
}
@end
