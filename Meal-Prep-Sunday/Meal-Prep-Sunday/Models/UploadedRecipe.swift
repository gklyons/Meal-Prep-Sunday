//
//  ManualRecipe.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class UploadedRecipe {
    
    var image: UIImage?
    var title: String
    var manualIngredients: [Ingredient]
    var directions: String?
    var uid: String
//    var user: String
    
    init(image: UIImage?, title: String, manualIngredients: [Ingredient], directions: String?, uid: String = UUID().uuidString) {
        
        self.image = image
        self.title = title
        self.manualIngredients = manualIngredients
        self.directions = directions
        self.uid = uid
//        self.user = user
    }
}// End of Class

extension UploadedRecipe {
    
    convenience init?(recipe: Recipe, ingredients: [Ingredient]) {
        
        //let image = recipe.image
        let title = recipe.label
        //let manualIngredients = recipe.ingredients
        let directions = recipe.directions
        
        self.init(image: nil, title: title, manualIngredients: ingredients, directions: directions)
    }
    
    convenience init?(dictionary: [String : Any]) {
        guard let 
        
//        guard let uploadedRecipes = UploadedRecipe(image: (documents.data()["image"] as? UIImage?), title: (documents.data()["title"] as? String), manualIngredients: (documents.data()["ingredients"] as? [Ingredient]), directions: (documents.data()["directions"] as? String?), uid: (documents.data()["uid"] as? String)) else { continue }
    }
}
