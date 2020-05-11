//
//  ShoppingListTableViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/8/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var menueIsctive = false
   // var ingredientList: Ingredient?
    var testArray: [Ingredient] = [Ingredient(item: "Pizza")]
    // MARK: -  Outlets
    @IBOutlet weak var menueButton: UIButton!
    @IBOutlet var menueContainerView: UIView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        menueContainerView.isHidden = true
    }
    
    // MARK: - Actions
    @IBAction func menueButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.menueContainerView.isHidden.toggle()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let ingrediant = testArray[indexPath.row]
        cell.updateViews(ingrediant: ingrediant)
        cell.delegate = self
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//    }
    
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//
//        }
//    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoppingListMenueSegue" {
            let menuVC = segue.destination as! ShoppingListMenueViewController
            menuVC.menueDelegate = self
        }
    }
}// End of Class

// MARK: - Delegate Extensions
extension ShoppingListTableViewController: menueButtonSelectedDelegate {
    func selectedButtonTapped() {
        // Need to add functionality
        menueContainerView.isHidden = true
        menueIsctive.toggle()
    }
}

extension ShoppingListTableViewController: ShoppingListTableViewCellDelegate {
    func toggleIngredientChecked(_ sender: ShoppingListTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let item = ShoppingListController.shared.shoppingList[index.row]
        ShoppingListController.shared.toggleItemChecked(ingredient: item)
    }
    
    
}

