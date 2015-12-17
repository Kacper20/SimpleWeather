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


class CurrentWeatherViewController: UIViewController, WeatherProviderSettable {
    var weatherProvider: WeatherItemProvider!
    
    
    
}
