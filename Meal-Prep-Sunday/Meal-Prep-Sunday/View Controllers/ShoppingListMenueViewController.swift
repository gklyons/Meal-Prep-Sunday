//
//  ShoppingListMenueViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/8/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

protocol menueButtonSelectedDelegate {
    func selectedButtonTapped(button: UIButton)
}

class ShoppingListMenueViewController: UIViewController {
    
    // MARK: - Properties
    var menueDelegate: menueButtonSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addSectionButtonTapped(_ sender: Any) {
        
    }
    @IBAction func reorganizeListButtonTapped(_ sender: Any) {
        
    }
    @IBAction func deleteAllButtonTapped(_ sender: Any) {
        ShoppingListController.shared.clearShoppingList()
    }
    
}// End of Class
