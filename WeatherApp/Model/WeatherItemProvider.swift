//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation

//Protocol describes that every WeatherProvider should give WeatherData for specified location
public protocol WeatherItemProvider {
    
    func getWeatherItemForLocation(location: GeoLocation, completion: (WeatherItem?, ErrorType?) -> Void)
}
//Protocol that describes what properties each WeatherItem should minimally have.
public protocol WeatherItem {
    
    var location: GeoLocation { get }
    var temperature: Double { get }
    var description: String { get }
    var temperatureMin: Double { get }
    var temperatureMax: Double { get }
    var humidity: Double { get }
    var pressure: Double { get }
    
}


