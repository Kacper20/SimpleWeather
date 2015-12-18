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
    
    @IBOutlet weak var blurredImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.hidden = true
        }
    }
    @IBOutlet weak var navbarRoundedView: NavbarRoundedView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var streetTownLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var tempMaxValueLabel: UILabel!
    @IBOutlet weak var tempMinValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var weatherProvider: WeatherItemProvider!
    var locationProvider: LocationProvider = LocationProvider()
    var navigationTheme: NavigationTheme = NavigationTheme.WhereAreYou
    var currentLocation: GeoLocation?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationProvider.delegate = self
        locationProvider.startUpdatingLocation()
        navbarRoundedView.applyTheme(navigationTheme)

    }
    

    override func viewDidLoad() {
        let blurEffect = UIBlurEffect(style: .Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = true
        blurView.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height + 12.0)
        blurredImageView.addSubview(blurView)
      
 
        
    }
    
    ///PRAGMA : LocationProviderDelegate
    
    func locationProviderDidFailGettingLocation(locationError: LocationProviderError) {
        switch locationError {
        case .LocationDeniedOrRestricted:
            //Handle errors...
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
                self.stackView.hidden = false
            }
            else {

                self.presentAlert("Error", description: "Error has occured during downloading data from the internet")
                

            }
        }
    }
    func presentAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /// Data population section
    
    private func updateWithLocationItem(descriptor: LocationDescriptor) {
        self.countryLabel.text = descriptor.country
        self.streetTownLabel.text = descriptor.city + ", " + descriptor.street
    }

    private func updateWithWeatherItem(weatherItem: WeatherItem) {
        
        let viewModel = WeatherItemViewModel(weatherItem: weatherItem)
        temperatureLabel.text = viewModel.temperatureText
        tempMaxValueLabel.text = viewModel.maxTemperatureText
        tempMinValueLabel.text = viewModel.minTemperatureText
        humidityValueLabel.text = viewModel.humidityText
        pressureValueLabel.text = viewModel.pressureText
        weatherDescriptionLabel.text = weatherItem.description
        navigationTheme = NavigationTheme(numberOfDegrees: weatherItem.temperature)
        navbarRoundedView.applyTheme(navigationTheme)        
    }
    
    
}


