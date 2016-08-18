//
//  AddCityViewController.m
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "AddCityViewController.h"
#import "AppDelegate.h"
#import "WeatherManager.h"

@interface AddCityViewController()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AddCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar setShowsCancelButton:YES];
    [self.searchBar becomeFirstResponder];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    WeatherManager* wm = [AppDelegate weatherManager];
    [wm addCity:searchBar.text];
    if (self.callback)
        self.callback();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
