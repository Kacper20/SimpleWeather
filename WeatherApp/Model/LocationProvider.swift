//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation
import CoreLocation

public struct LocationDescriptor {

    let street: String
    let city: String
    let country: String

}
extension LocationDescriptor {
    init(placemark: CLPlacemark) {
        self.country = placemark.country ?? ""
        self.city = placemark.locality ?? ""
        self.street = placemark.thoroughfare ?? "" + (placemark.subThoroughfare ?? "")
    }
}

enum LocationProviderError: ErrorType {
    
    case LocationDeniedOrRestricted
    case CouldNotGetGeodata

}

protocol LocationProviderDelegate: class {
    func locationProviderDidGetLocationWithDescription(location: GeoLocation, description: LocationDescriptor)
    func locationProviderDidFailGettingLocation(locationError: LocationProviderError)
}
//Location provider - basic class that takes responsibility for getting user location, and converting geographical location to meaningful address data.

final class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    
    weak var delegate: LocationProviderDelegate?
    let locationManager = CLLocationManager()
    
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
        if status == .Denied || status == .Restricted {
            delegate?.locationProviderDidFailGettingLocation(.LocationDeniedOrRestricted)
        }
    }
    func startUpdatingLocation() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()

        }
        else {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            kCLLocationAccuracyNearestTenMeters
            self.locationManager.distanceFilter = 1000.0;
            self.locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        let location = GeoLocation(longitude: latestLocation.coordinate.longitude, latitude: latestLocation.coordinate.latitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(latestLocation) { (placemarks, error) -> Void in
            if let placemarks = placemarks, let lastPlacemark = placemarks.last where error == nil {
                self.delegate?.locationProviderDidGetLocationWithDescription(location, description: LocationDescriptor(placemark: lastPlacemark))
            }
            else  {
                self.delegate?.locationProviderDidFailGettingLocation(.CouldNotGetGeodata)
            }
        }
        
    }
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
}