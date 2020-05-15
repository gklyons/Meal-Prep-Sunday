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
    var recipeRefrence: String?
    var uid: String
    
    init(item: String, isChecked: Bool = false, recipeRefrence: String? = nil, uid: String = UUID().uuidString) {
        self.item = item
        self.isChecked = isChecked
        self.recipeRefrence = recipeRefrence
        self.uid = uid
    }
}

func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
    return lhs.item == rhs.item &&
        lhs.isChecked == rhs.isChecked
    
}

extension Ingredient {
    
    convenience init(recipeUid: String, item: String) {
        self.init(item: item, recipeRefrence: recipeUid)
    }
}
