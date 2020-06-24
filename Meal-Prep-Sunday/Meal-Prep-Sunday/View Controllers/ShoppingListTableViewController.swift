//
//  ShoppingListTableViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/8/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import CoreGraphics

class ShoppingListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var menueIsctive = false
    // var ingredientList: Ingredient?
    var testArray: [Ingredient] = [Ingredient(item: "Pizza"), Ingredient(item: "Shrimp"), Ingredient(item: "Chicken Nuggies")]
    // MARK: -  Outlets
    @IBOutlet weak var menueButton: UIButton!
    @IBOutlet var menueContainerView: UIView!
    @IBOutlet weak var addIngredientTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        menueContainerView.isHidden = true
        //ShoppingListController.shared.loadFromPersistence()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func menueButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.menueContainerView.isHidden.toggle()
        }
    }
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        ShoppingListController.shared.addIngrediantToShoppingList(with: addIngredientTextField.text ?? "")
    }
    
    
    // MARK: - Table view data source
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        <#code#>
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // toDO change to SOT 
        return testArray.count
    }
    
    // toDo make sure to change testArray to our actual SOT
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let ingrediant = testArray[indexPath.row]
        cell.populateCell(ingredient: ingrediant)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 41
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 95
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
    
    // MARK: -  Helpers
    func setSectionTitle() {
        
    }
    
}// End of Class

// MARK: - Delegate Extensions
extension ShoppingListTableViewController: menueButtonSelectedDelegate {
    func selectedButtonTapped(button: UIButton) {
        menueContainerView.isHidden = true
        menueIsctive.toggle()
    }
}
// toDo Access SOT here
extension ShoppingListTableViewController: ShoppingListTableViewCellDelegate {
    func toggleIngredientChecked(_ sender: ShoppingListTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let item = testArray[index.row] //ShoppingListController.shared.shoppingList[index.row]
        ShoppingListController.shared.toggleItemChecked(ingredient: item)
        sender.populateCell(ingredient: item)
        
    }
    
}
