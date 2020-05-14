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
    var recipe: [Recipe]
    
    init(date: [Date], recipe: [Recipe]) {
        self.dateToEat = date
        self.recipe = recipe
    }
}// End of Class

extension MealPlan: Equatable {
    static func == (lhs: MealPlan, rhs: MealPlan) -> Bool {
        return lhs === rhs
        //lhs.date == rhs.date
    }
}//End of Extension
