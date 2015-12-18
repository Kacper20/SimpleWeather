//
//  Location.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 18.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation

//Created to not expose source of location(don't want anything that location provider depend on CoreLocation)
public struct GeoLocation: Equatable {
    let longitude: Double
    let latitude: Double
    init(longitude: Double, latitude: Double){
        self.longitude = longitude
        self.latitude = latitude
    }
}
public func ==(lhs: GeoLocation, rhs: GeoLocation) -> Bool {
    return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
}