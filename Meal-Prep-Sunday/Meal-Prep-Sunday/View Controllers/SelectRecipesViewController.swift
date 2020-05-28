//
//  SelectRecipesViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/14/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class SelectRecipesViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var recipeSelectedButton: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    // to grab all of the selected recipes -> call mealPlanPontroller.shared.savedMealPlan(with: recipes)
    //in controller func saveMealPlan with [Recipe] to tempMealPlan then save tempMealPlan to fireStore
    // nil out the tempMealPlan after siaving
    // add it to mealPlans in the mealPlanController (append it)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return RecipeController.shared.savedRecipes.count
        } else if section == 1 {
            return RecipeController.shared.uploadedRecipes.count
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipesCell", for: indexPath)
        if indexPath.section == 0 {
            let recipe = RecipeController.shared.savedRecipes[indexPath.row]
            cell.textLabel?.text = recipe.label
        } else if indexPath.section == 1 {
            let uploadedRecipe = RecipeController.shared.uploadedRecipes[indexPath.row]
            cell.textLabel?.text = uploadedRecipe.title
        }
        return cell
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
