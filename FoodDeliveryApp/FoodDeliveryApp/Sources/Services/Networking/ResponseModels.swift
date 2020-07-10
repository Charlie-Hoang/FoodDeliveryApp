//
//  ResponseModels.swift
//  FoodDeliveryApp
//
//  Created by Charlie on 10/7/20.
//  Copyright © 2020 C. All rights reserved.
//

import ObjectMapper

struct PromotionRes: Mappable {
    
    var promotions: [String]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        promotions <- map["promotions"]
    }
    
}

struct FoodsRes: Mappable {
    var foods: [Food]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        foods <- map["foods"]
    }
    
    struct Food: Mappable {
        var itemId: String?
        var name: String?
        var des: String?
        var img: String?
        var size: String?
        var weight: String?
        var price: Int?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            itemId <- map["itemId"]
            name <- map["name"]
            des <- map["des"]
            img <- map["img"]
            size <- map["size"]
            weight <- map["weight"]
            price <- map["price"]
        }
    }
}
