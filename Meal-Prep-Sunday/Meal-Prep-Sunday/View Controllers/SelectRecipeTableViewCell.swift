//
//  SelectRecipeTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/14/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

// Mark: - Protocols
protocol SelectRecipeTableViewCellDelegate: class {
    func toggleRecipeChecked(_ sender: SelectRecipeTableViewCell)
}

class SelectRecipeTableViewCell: UITableViewCell {
    
    // Mark: - Properties
    weak var delegate: SelectRecipeTableViewCellDelegate?
    
    // Mark: - Outlets
    @IBOutlet weak var savedRecipeCheckBoxChecked: UIButton!
    @IBOutlet weak var savedRecipeImageView: UIImageView!
    @IBOutlet weak var savedRecipeNameLabel: UILabel!
    @IBOutlet weak var savedRecipeCookTimeLabel: UILabel!
    
    var recipe: Recipe? {
        didSet {
            guard let recipe = recipe else {return}
            savedRecipeNameLabel.text = recipe.label
            savedRecipeCookTimeLabel.text = "\(recipe.totalTime) min"
//            update(withRecipe: recipe)
            
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
    
    func update(withRecipe recipe: Recipe) {
        savedRecipeCheckBoxChecked.setImage(recipe.isChecked ? #imageLiteral(resourceName: "Checked Box 1x") : #imageLiteral(resourceName: "Empty Checkbox 1x"), for: .normal)
    }
    
    @IBAction func checkBoxChecked(_ sender: Any) {
        delegate?.toggleRecipeChecked(self)
//        update(withRecipe: recipe!)
    }
}
