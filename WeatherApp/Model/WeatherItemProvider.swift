//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation





public struct GeoLocation: CustomStringConvertible, Equatable {
        
        var longitude: Double
        var latitude: Double
        init(longitude: Double, latitude: Double){
            self.longitude = longitude
            self.latitude = latitude
        }
    
        public var description: String {
            get {
                return "longitude: \(self.longitude), latitude: \(self.latitude)\n"
            }
        }
    }
    public func ==(lhs: GeoLocation, rhs: GeoLocation) -> Bool {
    return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
}

public protocol WeatherItem {
    
    var location: GeoLocation { get }
    var temperature: Double { get }
    var temperatureMin: Double { get }
    var temperatureMax: Double { get }
    var humidity: Double { get }
    var pressure: Double { get }
    
}

public protocol WeatherItemProvider {
    
    
    func getWeatherItemForLocation(location: GeoLocation, completion: (WeatherItem?, ErrorType?) -> Void)
}
