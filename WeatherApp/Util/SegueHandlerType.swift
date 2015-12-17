//
//  SegueHandlerType.swift
//  WeatherApp
//
//  Created by Kacper Harasim on 17.12.2015.
//  Copyright © 2015 Kacper Harasim. All rights reserved.
//

import UIKit

public protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}


extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    public func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { fatalError("Unknown segue: \(segue))") }
        return segueIdentifier
    }
    
    public func performSegue(segueIdentifier: SegueIdentifier) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: nil)
    }
    
}

