//
//  Recipe.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class Recipe {
    
    let title: String
    let image: String
    let ingredient: String
    let directions: String
    
    init(title: String, image: String, ingredient: String, directions: String) {
        self.title = title
        self.image = image
        self.ingredient = ingredient
        self.directions = directions
    }
}
