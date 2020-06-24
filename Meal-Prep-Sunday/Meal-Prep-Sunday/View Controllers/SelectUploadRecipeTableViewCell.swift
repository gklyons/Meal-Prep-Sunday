//
//  SelectUploadRecipeTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 6/23/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

//import UIKit
//
//class SelectUploadRecipeTableViewCell: UITableViewCell {
//
//    // Mark: - Outlets
//    @IBOutlet weak var checkBoxChecked: UIButton!
//    @IBOutlet weak var uploadRecipeImageView: UIImageView!
//    @IBOutlet weak var uploadRecipeLabel: UILabel!
//    
//    var uploadRecipe: UploadedRecipe? {
//        didSet {
//            guard let uploadRecipe = uploadRecipe else {return}
//            uploadRecipeLabel.text = uploadRecipe.label
////            checkBoxChecked.setImage(uploadRecipe., for: <#T##UIControl.State#>)
//            
//            RecipeController.shared.fetchUploadRecipeImage(for: uploadRecipe) { (result) in
//                switch result {
//                case .success(let image):
//                    DispatchQueue.main.async {
//                        self.uploadRecipeImageView.image = image
//                    }
//                case .failure(let error):
//                    print(error, error.localizedDescription)
//                }
//            }
//        }
//    }
//}
