//
//  Routerable.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 11/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit

protocol Routerable {
    static func createModule() -> UIViewController
}

extension Routerable{
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
