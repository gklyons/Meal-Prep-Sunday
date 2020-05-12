//
//  ManualRecipe.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class ManualRecipe {
    
    let image: UIImage?
    let title: String
    let manualIngredient: String
    let directions: String?
    
    init(image: UIImage?, title: String, manualIngredient: String, directions: String?) {
        self.image = image
        self.title = title
        self.manualIngredient = manualIngredient
        self.directions = directions
    }
}
