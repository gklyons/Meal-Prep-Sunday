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
    var isChecked: Bool
    init(item: String, isChecked: Bool = false) {
        self.item = item
        self.isChecked = isChecked
    }
}

func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.item == rhs.item &&
        lhs.isChecked == rhs.isChecked
    
}

