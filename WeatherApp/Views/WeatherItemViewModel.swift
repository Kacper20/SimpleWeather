//
//  WeatherItemViewModel.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation

struct WeatherItemViewModel {
    let weatherItem: WeatherItem

    let temperatureText: String
    let minTemperatureText: String
    let maxTemperatureText: String
    let humidityText: String
    let pressureText: String
    
    
    init(weatherItem: WeatherItem) {
        self.weatherItem = weatherItem
        self.temperatureText = weatherItem.temperature.formatToPlaces(1).plusUnit(.Celsius)
        self.minTemperatureText = weatherItem.temperatureMin.formatToPlaces(1).plusUnit(.Celsius)
        self.maxTemperatureText = weatherItem.temperatureMax.formatToPlaces(1).plusUnit(.Celsius)
        self.humidityText = weatherItem.humidity.formatToPlaces(1).plusUnit(.Percentage)
        self.pressureText = weatherItem.pressure.formatToPlaces(1).plusUnit(.Pressure)
        
    }
    
    
}
enum MetricUnit: String{
    case Celsius = "℃"
    case Fahrenheit = "℉"
    case Percentage = "%"
    case Pressure = "hPa"
}
extension String {
    func plusUnit(unit: MetricUnit) -> String {
        return self + " " + unit.rawValue
    }
}

extension Double {
    
    func formatToPlaces(places:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.maximumFractionDigits = places
        formatter.roundingMode = .RoundHalfDown
        return formatter.stringFromNumber(NSNumber(double: self))!
    }
}

