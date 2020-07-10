//
//  Cell.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 10/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import Foundation

protocol CellConfigurable {
    associatedtype Presenter
    func configCell(presenter: Presenter)
}
