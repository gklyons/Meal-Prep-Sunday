//
//  ShoppingList.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class ShoppingList {
    let ingredient: String
    let measurement: String
    
    @discardableResult
    init(ingredient: String, measurement: String) {
        self.ingredient = ingredient
        self.measurement = measurement
    }
}
