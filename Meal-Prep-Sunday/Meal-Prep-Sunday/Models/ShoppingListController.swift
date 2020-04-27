//
//  ShoppingListController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class ShoppingListController {
    
    // Mark: - Properties
    var shoppingLists: [ShoppingList] = []
    
    // Mark: - Crud Functions
    func create(ingredient: String, measurement: String) {
        let ingredient = ShoppingList(ingredient: ingredient, measurement: measurement)
        shoppingLists.append(ingredient)
    }
    
    func read() {
        
    }
    
    func update(ingredient: String, measurement: String) {
        
    }
    
    func delete() {
        
    }
    
}//End of class

