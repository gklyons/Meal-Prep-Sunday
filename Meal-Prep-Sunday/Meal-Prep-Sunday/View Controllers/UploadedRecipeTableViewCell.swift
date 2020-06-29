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
    @IBOutlet weak var uploadRecipeCheckBox: UIButton!
    

   var uploadRecipe: UploadedRecipe? {
       didSet {
           guard let uploadRecipe = uploadRecipe else {return}
           uploadRecipeNameLabel.text = uploadRecipe.label
           
        RecipeController.shared.fetchUploadRecipeImage(for: uploadRecipe) { (result) in
               switch result {
               case .success(let image):
                   DispatchQueue.main.async {
                       self.uploadRecipeImageView.image = image
                   }
               case .failure(let error):
                   print(error, error.localizedDescription)
               }
           }
       }
   }
    
    fileprivate func isRecipeSelected(_ isComplete: Bool) {
        uploadRecipeCheckBox.setImage(isComplete ? #imageLiteral(resourceName: "Checked Box 1x") : #imageLiteral(resourceName: "Empty Checkbox 1x"), for: .normal)
    }
    
    @IBAction func checkBoxChecked(_ sender: Any) {
        isRecipeSelected(true)
        
    }
    
}
