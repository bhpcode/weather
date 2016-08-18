//
//  WeatherPageViewController.m
//  weather
//
//  Created by Matthew Connor on 11/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//
#import "WeatherPageViewController.h"
#import "WeatherDetailViewController.h"
#import "UIViewController+Indexable.h"
#import "WeatherManager.h"

@interface WeatherPageViewController() <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController* pageViewController;
@end

@implementation WeatherPageViewController

#pragma mark - view lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;

    WeatherDetailViewController *startingViewController = [self viewControllerAtIndex:self.currentIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - delegate a

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
               viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = viewController.index;
    
    --index;
    
    if ((NSInteger)index < 0){
        index = self.manager.cities.count - 1;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController
                viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = viewController.index;
    
    ++index;
    
    if ((NSInteger)index >= self.manager.cities.count){
        index = 0;
    }
    
    return [self viewControllerAtIndex:index];
    
}


#pragma mark - view controller iteration


- (WeatherDetailViewController*) viewControllerAtIndex: (NSUInteger) index
{
    WeatherDetailViewController* detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailViewController"];
    detailVC.index =index;
    detailVC.weatherData = [self.manager.cities objectAtIndex:index];
    return detailVC;
}

@end
