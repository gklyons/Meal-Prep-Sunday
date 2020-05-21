//
//  RecipeError.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 4/28/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

enum RecipeError: LocalizedError {
   
    case invalidURL
    case thrown(Error)
    case noData
    case unableToDecode
    case noDirections
    
    // What the user sees
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach server."
        case .thrown(let error):
            return error.localizedDescription
        case .noData:
            return "Server responded with no data."
        case .unableToDecode:
            return "Server responded with bad data"
        case .noDirections:
            return "Oops! I can't seem to find directions for this recipe."
        }
    }
}
