//
//  CartEntities.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 11/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import Foundation

protocol CartFoodCellPresentable {
    var name: String?{get}
    var imgURL: String?{get}
    var price: Int?{get}
}
struct CartFoodCellViewModel: CartFoodCellPresentable{
    var model: FoodsRes.Food
    var name: String?{return model.name}
    var imgURL: String?{return model.img}
    var price: Int?{return model.price ?? 0}
    
    init(food: FoodsRes.Food) {
        self.model = food
    }
}
