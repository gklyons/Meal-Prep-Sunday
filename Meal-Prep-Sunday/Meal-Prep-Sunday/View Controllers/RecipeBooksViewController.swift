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
    
    static let shared = RecipeBookViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedRecipesTableView.isHidden = true
        uploadedRecipesTableView.isHidden = true
        savedRecipesButton.layer.borderWidth = 0.8
        uploadedRecipesButton.layer.borderWidth = 0.8
        setTitle()
//        pullSavedRecipes()
    }
    
    func setTitle() {
        let image: UIImage = UIImage(named: "Prep 120 1x")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.savedRecipeTableHeight.constant = self.savedRecipesTableView.contentSize.height
        self.uploadRecipeTableHeight.constant = self.uploadedRecipesTableView.contentSize.height
    }
    
    func pullSavedRecipes() {
        FirebaseStuff.shared.pullSavedRecipes { (completed) in
            if completed {
                DispatchQueue.main.async {
                    self.savedRecipesTableView.reloadData()
                }
            }
        }
        print("Saved Recipes: \(RecipeController.shared.savedRecipes)")
    }
    
    @IBAction func savedRecipesButtonTapped(_ sender: Any) {
        pullSavedRecipes()
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
            return RecipeController.shared.savedRecipes.count
        } else if tableView == uploadedRecipesTableView {
            return RecipeController.shared.uploadedRecipes.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == savedRecipesTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as? recipeBookTableViewCell else {return UITableViewCell()}
            let savedRecipe = RecipeController.shared.savedRecipes[indexPath.row]
//            cell.textLabel?.text = savedRecipe.label
//            cell.textLabel?.font = UIFont(name: "Palatino", size: 15)
            cell.savedRecipe = savedRecipe
            return cell
        } else if tableView == uploadedRecipesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "uploadCell", for: indexPath)
            let uploadedRecipe = RecipeController.shared.uploadedRecipes[indexPath.row]
            cell.textLabel?.text = uploadedRecipe.title
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}//End of class


