//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit
public protocol WeatherProviderSettable: class {
    var weatherProvider: WeatherItemProvider! { get set }
}


class CurrentWeatherViewController: UIViewController, WeatherProviderSettable, LocationProviderDelegate {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var streetTownLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var tempMaxValueLabel: UILabel!
    @IBOutlet weak var tempMinValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    
    var weatherProvider: WeatherItemProvider!
    var locationProvider: LocationProvider = LocationProvider()
    var navigationTheme: NavigationTheme = NavigationTheme.WhereAreYou
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationProvider.delegate = self
        locationProvider.startUpdatingLocation()

    }
    var currentLocation: GeoLocation?
    
    
    ///PRAGMA : LocationProviderDelegate
    
    func locationProviderDidFailGettingLocation(locationError: LocationProviderError) {
        switch locationError {
        case .LocationDeniedOrRestricted:
            print("")
        case .CouldNotGetGeodata:
            print("")
        }
    }
    
    func locationProviderDidGetLocationWithDescription(location: GeoLocation, description: LocationDescriptor) {
        guard location != currentLocation else { return }
        
        updateWithLocationItem(description)
        self.currentLocation = location
        weatherProvider.getWeatherItemForLocation(location) { (weatherItem, error) -> Void in
            if let item = weatherItem where error == nil {
                self.updateWithWeatherItem(item)
            }
            else {
                
                
            }
        }
        
    }
    
    func updateWithLocationItem(descriptor: LocationDescriptor) {
        self.countryLabel.text = descriptor.country
        self.streetTownLabel.text = descriptor.city + ", " + descriptor.street
    }

    func updateWithWeatherItem(weatherItem: WeatherItem) {
        
        let viewModel = WeatherItemViewModel(weatherItem: weatherItem)
        self.temperatureLabel.text = viewModel.temperatureText
        self.tempMaxValueLabel.text = viewModel.maxTemperatureText
        self.tempMinValueLabel.text = viewModel.minTemperatureText
        self.humidityValueLabel.text = viewModel.humidityText
        self.pressureValueLabel.text = viewModel.pressureText
        navigationController?.navigationBar.applyTheme(navigationTheme)
//        navigationController?.statusBarStyle = navigationTheme.statusBarStyle
        
    }
    
    
}


