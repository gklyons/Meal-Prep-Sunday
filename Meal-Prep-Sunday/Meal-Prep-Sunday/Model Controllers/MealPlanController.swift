//
//  MealPlanController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 4/28/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class MealPlanController {
    // MARK: - Properties
    static let shared = MealPlanController()
    var mealPlans: [MealPlan] = []
    
    // MARK: - CRUD Functions
    func createMealPlan(with recipe: [Recipe], date: [Date]) {
        let mealPlan = MealPlan(date: date, recipe: recipe)
        self.mealPlans.append(mealPlan)
    }
    
    func deleteMealPlan(mealPlan: MealPlan) {
        guard let index = mealPlans.firstIndex(of: mealPlan) else { return }
        mealPlans.remove(at: index)
    }
    
    func updateMealPlan(mealPlan: MealPlan, updatedDate: [Date], updatedRecipe: [Recipe]) {
        mealPlan.recipe = updatedRecipe
        mealPlan.dateToEat = updatedDate
    }
    
    // MARK: - Helper Functions
//    func getRecipeInfo(recipe: Recipe) {
//        for recipeInfo in recipe.image ?? "" + recipe.label + "\(recipe.totalTime)" {
//            self.mealPlans.append(Recipe(label: "\(recipeInfo)", image: "\(recipeInfo)", directions: "", ingredients: "\(recipeInfo)", yield: 0, totalTime: recipeInfo))
//        }
//    }
}// End of Class
