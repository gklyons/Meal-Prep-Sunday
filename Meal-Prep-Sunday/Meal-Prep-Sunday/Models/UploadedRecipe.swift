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
    var label: String
    var manualIngredients: [Ingredient]
    var directions: String?
    var uid: String
    var imageEndpoint: String?
    var isChecked: Bool = false
    
    init(image: UIImage?, title: String, manualIngredients: [Ingredient], directions: String?, uid: String = UUID().uuidString, imageEndpoint: String? = nil, isChecked: Bool = false) {
        
        self.image = image
        self.label = title
        self.manualIngredients = manualIngredients
        self.directions = directions
        self.uid = uid
        self.imageEndpoint = imageEndpoint
        self.isChecked = isChecked
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
    
//    convenience init?(dictionary: [String : Any]) {
//        
//        guard let title = dictionary["title"] as? String,
//            let uid = dictionary["uid"] as? String
//                else { return nil }
//            let directions = dictionary["directions"] as? String
//        
//        self.init(title: title, uid: uid, directions: directions)
//    }
}

extension UploadedRecipe: Equatable {
    static func == (lhs: UploadedRecipe, rhs: UploadedRecipe) -> Bool {
        return lhs === rhs
    }
}
