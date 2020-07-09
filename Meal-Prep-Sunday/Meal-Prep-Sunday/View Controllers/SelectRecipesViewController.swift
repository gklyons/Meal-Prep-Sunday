//
//  SelectRecipesViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/14/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class SelectRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    //    @IBOutlet weak var recipeSelectedButton: NSLayoutConstraint!
    @IBOutlet weak var savedRecipesDropDownButton: UIButton!
    @IBOutlet weak var savedRecipeTableView: UITableView!
    @IBOutlet weak var uploadedRecipesDropDownButton: UIButton!
    @IBOutlet weak var uploadedRecipeTableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        savedRecipeTableView.isHidden = true
        uploadedRecipeTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        FirebaseStuff.shared.getSavedRecipeCollection()
        FirebaseStuff.shared.getUploadRecipeCollection()
    }
    
    // MARK: - Actions
    // to grab all of the selected recipes -> call mealPlanPontroller.shared.savedMealPlan(with: recipes)
    //in controller func saveMealPlan with [Recipe] to tempMealPlan then save tempMealPlan to fireStore
    // nil out the tempMealPlan after siaving
    // add it to mealPlans in the mealPlanController (append it)
    @IBAction func savedRecipeButtonTapped(_ sender: Any) {
        if savedRecipeTableView.isHidden {
            savedRecipeTableView.reloadData()
            animateSaved(toggle: true)
        } else {
            animateSaved(toggle: false)
        }
    }
    
    func animateSaved(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.savedRecipeTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.savedRecipeTableView.isHidden = true
            }
        }
    }
    
    @IBAction func uploadedRecipeButtonTapped(_ sender: Any) {
        if uploadedRecipeTableView.isHidden {
            uploadedRecipeTableView.reloadData()
            animateUpload(toggle: true)
        } else {
            animateUpload(toggle: false)
        }
    }
    
    func animateUpload(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.uploadedRecipeTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.uploadedRecipeTableView.isHidden = true
            }
        }
    }
    
    @IBAction func savedRecipeCheckBoxTapped(_ sender: Any) {
        
    }
    
    @IBAction func uploadedRecipeCheckBoxTapped(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == savedRecipeTableView {
            return RecipeController.shared.savedRecipes.count
        } else if tableView == uploadedRecipeTableView {
            return RecipeController.shared.uploadedRecipes.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == savedRecipeTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as? SelectRecipeTableViewCell else {return UITableViewCell()}
            let savedRecipe = RecipeController.shared.savedRecipes[indexPath.row]
            cell.recipe = savedRecipe
            RecipeController.shared.toggleSavedRecipeChecked(recipe: savedRecipe)
            return cell
        } else if tableView == uploadedRecipeTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "uploadCell", for: indexPath) as? UploadedRecipeTableViewCell else {return UITableViewCell()}
            let uploadedRecipe = RecipeController.shared.uploadedRecipes[indexPath.row]
            cell.uploadRecipe = uploadedRecipe
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}

extension SelectRecipesViewController: SelectRecipeTableViewCellDelegate {
    func toggleRecipeChecked(_ sender: SelectRecipeTableViewCell) {
        guard let index = savedRecipeTableView.indexPath(for: sender) else {return}
        let recipe = RecipeController.shared.savedRecipes[index.row]
        RecipeController.shared.toggleSavedRecipeChecked(recipe: recipe)
        sender.update(withRecipe: recipe)
    }
}
