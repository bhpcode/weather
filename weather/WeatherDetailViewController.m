//
//  WeatherDetailViewController.m
//  weather
//
//  Created by Matthew Connor on 09/08/2016.
//  Copyright © 2016 Matthew Connor. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "WeatherData.h"
#import "AppDelegate.h"
#import "WeatherImageManager.h"

@interface WeatherDetailViewController()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *minTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;

@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windGustTempLabel;

@property (weak, nonatomic) IBOutlet UIView *tempContainerView;
@property (weak, nonatomic) IBOutlet UIView *windContainerView;

@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;

@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UIView *suntimesContainer;
@property (weak, nonatomic) IBOutlet UIView *humidityPressureContainerView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIView *cityContainerView;
@end

@implementation WeatherDetailViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.cityLabel.text = self.weatherData.city;
    self.cityDescriptionLabel.text = [self.weatherData weatherDescriptionString];
    
    self.minTempLabel.text = [self.weatherData tempToString:self.weatherData.tempMin];
    self.maxTempLabel.text = [self.weatherData tempToString:self.weatherData.tempMax];
    self.currentTempLabel.text = [self.weatherData tempToString:self.weatherData.temp];
    
    self.windSpeedLabel.text = [self.weatherData kmhToString:self.weatherData.windSpeed];
    self.windDirectionLabel.text = [self.weatherData degreesToString:self.weatherData.windDirection];
    self.windGustTempLabel.text = [self.weatherData kmhToString:self.weatherData.windGust];
    
    self.tempContainerView.layer.cornerRadius = 6.f;
    self.windContainerView.layer.cornerRadius = 6.f;
    self.suntimesContainer.layer.cornerRadius = 6.f;
    self.humidityPressureContainerView.layer.cornerRadius = 6.f;
    self.cityContainerView.layer.cornerRadius = 6.f;
    
    self.sunriseLabel.text = [self.weatherData timeToString: self.weatherData.sunrise];
    
    self.sunsetLabel.text = [self.weatherData timeToString: self.weatherData.sunset];
    
    self.humidityLabel.text = [self.weatherData humidityToString];
    self.pressureLabel.text = [self.weatherData pressureToString];
    
    self.iconImageView.image = [[AppDelegate weatherManager].imageManager iconForWeatherID:self.weatherData.weatherId];
    
    self.closeButton.hidden = TRUE;
    
}

- (IBAction)closePressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
