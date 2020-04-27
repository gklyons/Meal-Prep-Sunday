//
//  ShoppingList.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class ShoppingList: Equatable, Codable {
    var ingredient: String
    var measurement: String
    
    @discardableResult
    init(ingredient: String, measurement: String) {
        self.ingredient = ingredient
        self.measurement = measurement
    }
}

func ==(lhs: ShoppingList, rhs: ShoppingList) -> Bool {
    return lhs.ingredient == rhs.ingredient && lhs.measurement == rhs.measurement
}
