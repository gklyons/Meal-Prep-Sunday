//
//  ShoppingListTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/8/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol ShoppingListTableViewCellDelegate: class {
    func toggleIngredientChecked(_ sender: ShoppingListTableViewCell)
}

class ShoppingListTableViewCell: UITableViewCell {
   
    // MARK: - Properties
    weak var delegate: ShoppingListTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var editIngredientButton: UIButton!
    
    // MARK: -  Actions
    @IBAction func checkBoxButtonTapped(_ sender: Any) {
        delegate?.toggleIngredientChecked(self)
    }
    @IBAction func editIngredientButtonTapped(_ sender: Any) {
        ingredientTextField.isUserInteractionEnabled.toggle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func populateCell(ingrediant: Ingredient) {
//        ingredientTextField.isUserInteractionEnabled.toggle()
        ingredientTextField.text = ingrediant.item
        checkBoxButton.setImage(ingrediant.isChecked ? #imageLiteral(resourceName: "Checked Box 1x") : #imageLiteral(resourceName: "Empty Checkbox 1x"), for: .normal)
    }
    
}
