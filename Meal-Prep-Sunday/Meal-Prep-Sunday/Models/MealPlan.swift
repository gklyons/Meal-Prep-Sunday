//
//  MealPlan.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class MealPlan {
    
    let date: Date
    let recipe: Recipe
    
    init(date: Date, recipe: Recipe) {
        self.date = date
        self.recipe = recipe
    }
}
