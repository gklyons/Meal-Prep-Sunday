//
//  RecipeBooksViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/4/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class RecipeBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var savedRecipesButton: UIButton!
    @IBOutlet weak var savedRecipesTableView: UITableView!
    @IBOutlet weak var uploadedRecipesButton: UIButton!
    @IBOutlet weak var uploadedRecipesTableView: UITableView!
    @IBOutlet weak var savedRecipeTableHeight: NSLayoutConstraint!
    @IBOutlet weak var uploadRecipeTableHeight: NSLayoutConstraint!
    
    var recipeList = ["Chicken Vesuvio", "Peanut Butter and Jelly", "Cocoa Pebbles", "Rice Bowl","Chicken Vesuvio", "Peanut Butter and Jelly", "Cocoa Pebbles", "Rice Bowl", "Chicken Vesuvio", "Peanut Butter and Jelly", "Cocoa Pebbles", "Rice Bowl","Chicken Vesuvio", "Peanut Butter and Jelly", "Cocoa Pebbles", "Rice Bowl"]
    var uploadList = ["Roast", "Pork Chops", "Cake", "Turkey", "Roast", "Pork Chops", "Cake", "Turkey", "Roast", "Pork Chops", "Cake", "Turkey"]

    override func viewDidLoad() {
        super.viewDidLoad()
        savedRecipesTableView.isHidden = true
        uploadedRecipesTableView.isHidden = true
        savedRecipesButton.layer.borderWidth = 0.8
        uploadedRecipesButton.layer.borderWidth = 0.8
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.savedRecipeTableHeight.constant = self.savedRecipesTableView.contentSize.height
        self.uploadRecipeTableHeight.constant = self.uploadedRecipesTableView.contentSize.height
    }
        
    
    @IBAction func savedRecipesButtonTapped(_ sender: Any) {
        if savedRecipesTableView.isHidden {
            animateSaved(toggle: true)
        } else {
            animateSaved(toggle: false)
        }
    }
    
    func animateSaved(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.savedRecipesTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.savedRecipesTableView.isHidden = true
            }
        }
    }
    
    @IBAction func uploadedRecipesButtonTapped(_ sender: Any) {
        if uploadedRecipesTableView.isHidden {
            animateUpload(toggle: true)
        } else {
            animateUpload(toggle: false)
        }
    }
    
    func animateUpload(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.uploadedRecipesTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.uploadedRecipesTableView.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == savedRecipesTableView {
            return recipeList.count
        } else if tableView == uploadedRecipesTableView {
            return uploadList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == savedRecipesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath)
            cell.textLabel?.text = recipeList[indexPath.row]
            return cell
        } else if tableView == uploadedRecipesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "uploadCell", for: indexPath)
            cell.textLabel?.text = uploadList[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}//End of class


