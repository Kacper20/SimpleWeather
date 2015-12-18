//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit


class RootViewController: UIViewController, SegueHandlerType {
    
    
    enum SegueIdentifier: String {
        case EmbedNavigation = "EmbedWeatherVc"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue) {
        case .EmbedNavigation:
            guard let vc = segue.destinationViewController as? WeatherProviderSettable else { fatalError("Wrong vc!!") }
            vc.weatherProvider = OpenWeatherItemProvider()

        }
    }
    
    
    
    
    
}
