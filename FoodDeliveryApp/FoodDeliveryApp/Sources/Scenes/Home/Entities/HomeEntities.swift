//
//  HomeEntities.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 9/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import Foundation

//struct Food {
//    let id: String?
//    let name: String?
//    let pictureURL: String?
//}
//
protocol FoodCellPresentable {
    var id: String?{get}
    var name: String?{get}
    var description: String?{get}
    var imgURL: String?{get}
    var packageDescription: String?{get}
    var price: String?{get}
}
struct FoodCellViewModel: FoodCellPresentable{
    var model: FoodsRes.Food
    var id: String?{return model.itemId}
    var name: String?{return model.name}
    var description: String?{return model.des}
    var imgURL: String?{return model.img}
    var packageDescription: String?{return "\(model.size ?? "") \(model.weight ?? "")"}
    var price: String?{return String(model.price ?? 0)}
    
    init(food: FoodsRes.Food) {
        self.model = food
    }
}

