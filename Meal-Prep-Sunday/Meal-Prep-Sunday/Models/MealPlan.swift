//
//  MealPlan.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class MealPlan {
    
    var date: Date
    var recipe: [Recipe]
    var isChecked: Bool
    
    init(date: Date, recipe: [Recipe], isChecked: Bool = false) {
        self.date = date
        self.recipe = recipe
        self.isChecked = isChecked
    }
}// End of Class

extension MealPlan: Equatable {
    static func == (lhs: MealPlan, rhs: MealPlan) -> Bool {
       lhs.date == rhs.date
    }
}
