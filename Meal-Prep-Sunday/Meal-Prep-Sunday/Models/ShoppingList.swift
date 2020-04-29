//
//  ShoppingList.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class ShoppingList: Codable {
    
    var ingredients: [Ingredient]
    
//    @discardableResult
    init(ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
    
//    required init(from decoder:Decoder) throws {
//        self.ingredients = decoder.self
//    }
}


