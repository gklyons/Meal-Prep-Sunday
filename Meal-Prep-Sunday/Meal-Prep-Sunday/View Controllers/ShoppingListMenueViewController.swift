//
//  ShoppingListMenueViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/8/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

protocol menueButtonSelectedDelegate {
    func selectedButtonTapped()
}

class ShoppingListMenueViewController: UIViewController {
    
    // MARK: - Properties
    var menueDelegate: menueButtonSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addIngrediantButtonTapped(_ sender: Any) {
        
    }
    @IBAction func addRecipeButtonTapped(_ sender: Any) {
        
    }
    @IBAction func deleteAllButtonTapped(_ sender: Any) {
        ShoppingListController.shared.clearShoppingList()
    }
    
}// End of Class
