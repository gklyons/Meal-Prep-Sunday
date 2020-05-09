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
        ingredientTextField.isUserInteractionEnabled = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func updateViews() {
        
    }
}
