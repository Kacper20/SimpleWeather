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
    

    var tintColor: UIColor? {
        switch self {
        case .Cold: return UIColor(red:0.93, green:0.95, blue:0.95, alpha:1)
        case .Normal: return UIColor(red:0.18, green:0.24, blue:0.32, alpha:1)
        case .Hot:  return  UIColor(red:0.91, green:0.5, blue:0.18, alpha:1)
        case .ExtremelyHot: return UIColor(red:0.91, green:0.3, blue:0.24, alpha:1)
        case .WhereAreYou:  return UIColor(red:0.18, green:0.24, blue:0.32, alpha:1)
        }
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