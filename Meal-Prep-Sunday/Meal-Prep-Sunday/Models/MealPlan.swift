//
//  MealPlan.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class MealPlan {
    
    var dateToEat: [Date]
    var recipes: [Recipe]
    
    init(date: [Date], recipes: [Recipe]) {
        self.dateToEat = date
        self.recipes = recipes
    }
}// End of Class

extension MealPlan: Equatable {
    static func == (lhs: MealPlan, rhs: MealPlan) -> Bool {
        return lhs === rhs
        //lhs.date == rhs.date
    }
}//End of Extension
