//
//  RecipeDetailViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 5/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    var uploadedRecipe: UploadedRecipe?
    //    var ingredients: [Ingredient] = []
    
    @IBOutlet weak var recipeIngredientsListTV: UITableView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeCookTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeIngredientsListTV.delegate = self
        recipeIngredientsListTV.dataSource = self
        guard let recipe = recipe else { return }
        fetchImageAndUpdateViews(recipe: recipe)
        guard let uploadedRecipe = uploadedRecipe else { return }
        fetchUploadedImageandUpdateViews(uploadedRecipe: uploadedRecipe)
    }
    
    func fetchImageAndUpdateViews(recipe: Recipe) {
        RecipeController.shared.fetchImage(for: recipe) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.recipeImage.image = image
                    self.recipeName.text = recipe.label
                    self.recipeCookTime.text = "Cook Time: \(recipe.totalTime)"
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
    
    func fetchUploadedImageandUpdateViews(uploadedRecipe: UploadedRecipe) {
        RecipeController.shared.fetchUploadRecipeImage(for: uploadedRecipe) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.recipeImage.image = image
                    self.recipeName.text = uploadedRecipe.label
                    self.recipeCookTime.text = nil
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func seeDirectionsButtonTapped(_ sender: Any) {
        if recipe == recipe {
            guard let recipe = recipe else {return}
            if let url = URL(string: recipe.directions) {
                UIApplication.shared.canOpenURL(url)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if uploadedRecipe == uploadedRecipe {
            guard let recipe = uploadedRecipe else {return}
            if let url = URL(string: recipe.directions!) {
                UIApplication.shared.canOpenURL(url)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func addToRecipeBookButtonTapped(_ sender: Any) {
        guard let recipe = recipe else {return}
        RecipeController.shared.savedRecipes.append(recipe)
        FirebaseStuff.shared.saveRecipe(recipe: recipe)
        print("Saved Recipes: \(RecipeController.shared.savedRecipes.count)")
        navigationController?.popViewController(animated: true)
    }
}//End of Class

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recipeIngredientsListTV {
            guard let recipe = recipe else { return 0}
            return recipe.ingredients.count
        } else {
            guard let uploadedRecipe = uploadedRecipe else {return 0}
            return uploadedRecipe.manualIngredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListTV", for: indexPath)
        let ingredient = recipe!.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}


