//
//  NavigationTheme.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit

enum NavigationTheme {
    case Cold
    case Normal
    case Hot
    case ExtremelyHot
    case WhereAreYou
    
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .Normal, .Cold: return .Default
        case .Hot, .ExtremelyHot, .WhereAreYou: return .LightContent
        }
    }
    
    var barTintColor: UIColor? {
        return nil
    }
    
    var titleTextAttributes: [String: NSObject]? {
        return nil
    }
    
    var tintColor: UIColor? {
        return nil
    }
}

extension NavigationTheme {
    
    init (numberOfDegrees: Double) {
        switch numberOfDegrees {
        case -60..<14.0:
            self = .Cold
        case 14..<24:
            self = .Normal
        case 24..<30:
            self = .Hot
        case 30..<100:
            self = .ExtremelyHot
        default:
            self = .WhereAreYou
        }
        
        
    }
    

}