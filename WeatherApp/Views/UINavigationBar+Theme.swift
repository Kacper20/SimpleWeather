//
//  UINavigationBar+Theme.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit


extension UINavigationBar {
    func applyTheme(navigationTheme: NavigationTheme) {
        barTintColor = navigationTheme.barTintColor
        tintColor = navigationTheme.tintColor
        titleTextAttributes = navigationTheme.titleTextAttributes
    }
}
