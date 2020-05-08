//
//  SearchViewTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/7/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class SearchViewTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    var recipe: Recipe? {
        didSet {
            guard let recipe = recipe else {return}
            recipeNameLabel.text = recipe.label
            cookTimeLabel.text = "\(recipe.totalTime) min"
            
            RecipeController.shared.fetchImage(for: recipe) { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.recipeImageView.image = image
                    }
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
