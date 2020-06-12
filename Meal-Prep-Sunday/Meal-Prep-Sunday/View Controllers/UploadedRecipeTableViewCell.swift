//
//  UploadedRecipeTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 6/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class UploadedRecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uploadRecipeNameLabel: UILabel!
    @IBOutlet weak var uploadRecipeImageView: UIImageView!
    

//   var uploadRecipe: UploadedRecipe? {
//       didSet {
//           guard let uploadRecipe = uploadRecipe else {return}
//           uploadRecipeNameLabel.text = uploadRecipe.label
////           uploadRecipeCookTimeLabel.text = "\(recipe.totalTime) min"
//           
//           RecipeController.shared.fetchImage(for: uploadRecipe) { (result) in
//               switch result {
//               case .success(let image):
//                   DispatchQueue.main.async {
//                       self.uploadRecipeImageView.image = image
//                   }
//               case .failure(let error):
//                   print(error, error.localizedDescription)
//               }
//           }
//       }
//   }
}
