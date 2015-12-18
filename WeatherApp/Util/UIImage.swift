//
//  UIImage.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit
public enum AssetIdentifier: String {
    // Image Names of Minions
    case BlurredBackground = "color_fest"
}
extension UIImage {
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}