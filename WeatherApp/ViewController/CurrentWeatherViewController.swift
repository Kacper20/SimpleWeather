//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit
import CoreLocation
public protocol WeatherProviderSettable: class {
    var weatherProvider: WeatherItemProvider! { get set }
}


class CurrentWeatherViewController: UIViewController, WeatherProviderSettable, LocationProviderDelegate {
    var weatherProvider: WeatherItemProvider!
    var locationProvider: LocationProvider = LocationProvider() {
        didSet {
            locationProvider.delegate = self
            locationProvider.startUpdatingLocation()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    
    //PRAGMA : LocationProviderDelegate
    
    func locationProviderDidFailGettingLocation(locationError: LocationProviderError) {
        switch locationError {
        case .LocationDeniedOrRestricted:
            print("")
        case .CouldNotGetGeodata:
            print("")
        }
    }
    func locationProviderDidGetLocationWithDescription(location: GeoLocation, description: LocationDescriptor) {
        
    }
    
    
    
}
