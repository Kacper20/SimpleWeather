//
//  OpenWeatherAPIClient.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import Foundation
import Alamofire
final class WeatherAPIClient {
    /// getAPI: Function used to doing get API requests
    class func getAPI(baseUrl: String, endpoint: String, parameters: [String: AnyObject]?) -> Request {
        return request(.GET, baseUrl + endpoint, parameters: parameters, encoding: .URL, headers: nil)
            .jsonValidate()
    }
}
extension Request {
    func jsonValidate() -> Self {
        return self.validate(contentType: ["application/json"]).validate(statusCode: 200..<300)
    }
}