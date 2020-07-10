//
//  Identifier.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 10/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import UIKit

protocol Identifier {
    static var identifier: String{get}
}
extension Identifier{
    static var identifier: String {
        return String(describing: self)
    }
}
extension UIView: Identifier{}
extension UITableView{
    func regCell<CellName>(cell: CellName.Type) where CellName: UITableViewCell{
        self.register(UINib(nibName: CellName.identifier, bundle: nil),
                      forCellReuseIdentifier: CellName.identifier)
    }
}
