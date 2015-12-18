//
//  NavbarRoundedView.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 18.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit

class NavbarRoundedView: UIView {
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 16.0
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
    func applyTheme(navigationTheme: NavigationTheme) {
        self.layer.borderColor = navigationTheme.tintColor?.CGColor
        weatherLabel.textColor = navigationTheme.tintColor
    }
}
