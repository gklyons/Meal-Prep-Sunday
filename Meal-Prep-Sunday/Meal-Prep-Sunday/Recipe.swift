//
//  Recipe.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class Recipe {
    let title: String
    let image: String
    let ingrediants: String
    let directions: String
    
    init(title: String, image: String, ingrediants: String, directions: String) {
        self.title = title
        self.image = image
        self.ingrediants = ingrediants
        self.directions = directions
    }
}
