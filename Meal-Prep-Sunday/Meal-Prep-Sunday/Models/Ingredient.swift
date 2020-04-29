//
//  Ingredient.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 4/28/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class Ingredient: Codable, Equatable {
    var item: String
    
    init(item: String) {
        self.item = item
    }
}

//extension Ingredient: Equatable {
func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.item == rhs.item
    
}

