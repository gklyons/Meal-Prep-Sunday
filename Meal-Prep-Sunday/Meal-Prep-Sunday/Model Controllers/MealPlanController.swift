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
    var tempMealPlan: MealPlan?
    
    // MARK: - CRUD Functions
//    func createMealPlans(with recipe: [Recipe], date: [Date]) {
//        let mealPlan = MealPlan(date: date, recipes: recipe)
//        self.mealPlans.append(mealPlan)
//    }
    
    // FIXME: - Create saveMealPlan

    func deleteMealPlan(mealPlan: MealPlan) {
        guard let index = mealPlans.firstIndex(of: mealPlan) else { return }
        mealPlans.remove(at: index)
    }
    
    func updateMealPlan(mealPlan: MealPlan, updatedDate: [Date], updatedRecipe: [Recipe]) {
        mealPlan.recipes = updatedRecipe
        mealPlan.dateToEat = updatedDate
    }
    
    func createTempMealPlan(with startDate: Date, endDate: Date) {
         let numberOfSecondsInDay: Double = 60 * 60 * 24
         let numberOfDays = daysBetween(startDate: startDate.startOfDay() ?? Date(), endDate: endDate.startOfDay() ?? Date())
         var dates: [Date] = [startDate.startOfDay() ?? Date()]
         for _ in 1...numberOfDays {
             guard let newDate = dates.last?.addingTimeInterval(numberOfSecondsInDay) else { continue }
             dates.append(newDate)
         }
         tempMealPlan = MealPlan(date: dates, recipes: [])
     }
     
     private func daysBetween(startDate: Date, endDate: Date) -> Int
     {
         let calendar = Calendar.current
         let components  = calendar.dateComponents([.day], from: startDate, to: endDate)
         
         return components.day ?? 0
     }
    
    // MARK: - Helper Functions
//    func getSelectedRecipe(recipe: [Recipe]) {
//        for selectedRecipe in recipe {
//            RecipeController.shared.recipes
//        }
//    }
    
    //    func getRecipes(recipe: Recipe) {
//        for recipes in recipe {
//            self.mealPlans.append(Recipe())
//        }
//    }
}// End of Class

// MARK: - Extenstions
fileprivate extension Date {
    func startOfDay() -> Date? {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)
    }
}
