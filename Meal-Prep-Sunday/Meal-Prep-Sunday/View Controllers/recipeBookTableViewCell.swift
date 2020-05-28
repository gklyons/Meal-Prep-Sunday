//
//  recipeBookTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class recipeBookTableViewCell: UITableViewCell {

    @IBOutlet weak var savedRecipeImageView: UIImageView!
    @IBOutlet weak var savedRecipeNameLabel: UILabel!
    @IBOutlet weak var savedRecipeCookTimeLabel: UILabel!
    
    var savedRecipe: Recipe? {
        didSet {
            guard let recipe = savedRecipe else {return}
            savedRecipeNameLabel.text = recipe.label
            savedRecipeCookTimeLabel.text = "\(recipe.totalTime) min"
            
            RecipeController.shared.fetchImage(for: recipe) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.savedRecipeImageView.image = image
                    }
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
    
}//End of Class
