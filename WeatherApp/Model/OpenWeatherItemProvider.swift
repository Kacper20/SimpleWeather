//
//  OpenWeatherItemProvider.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation
import SwiftyJSON



public struct OpenWeatherItem : WeatherItem {
    public let  location: GeoLocation
    public let temperature: Double
    public let temperatureMin: Double
    public let temperatureMax: Double
    public let humidity: Double
    public let pressure: Double
    public let description: String
    
    init(json: JSON) {
        
        let longitude = json["coord"]["lon"].doubleValue
        let latitude = json["coord"]["lat"].doubleValue
        self.location = GeoLocation(longitude: longitude, latitude: latitude)
        
        let main = json["main"]
        self.temperature = main["temp"].doubleValue
        self.temperatureMin = main["temp_min"].doubleValue
        self.temperatureMax = main["temp_max"].doubleValue
        self.humidity = main["humidity"].doubleValue
        self.pressure = main["pressure"].doubleValue
        let arr = json["weather"].arrayValue
        self.description = { _ -> String in
            guard let first = arr.first else { return "" }
            return first["description"].stringValue
        }()

    }
    
}


public struct OpenWeatherItemProvider: WeatherItemProvider {
    
    let baseOpenWeatherUrl = "http://api.openweathermap.org/data/2.5/"
    let appId = "93164806d73e92a27299a82531c31aae"
    
    public func getWeatherItemForLocation(location: GeoLocation, completion: (WeatherItem?, ErrorType?) -> Void) {
        let params: [String : AnyObject] = [
            "lat" : location.latitude,
            "lon" : location.longitude,
            "appid" : appId,
            "units" : "metric"
        ]
        WeatherAPIClient.getAPI(baseOpenWeatherUrl, endpoint: "weather", parameters: params).responseData { (response) -> Void in
            switch  response.result {
            case .Success(let valData):
                let json = JSON(data: valData)
                print(json)
                let openWeatherItem = OpenWeatherItem(json: json)
                completion(openWeatherItem, nil)
            case .Failure(let err):
                completion(nil, err)
            }
        }
    }
}