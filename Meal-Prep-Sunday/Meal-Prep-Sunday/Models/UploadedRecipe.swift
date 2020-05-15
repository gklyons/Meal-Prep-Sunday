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
}


