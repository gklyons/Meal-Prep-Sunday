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
    
    @IBAction func seeDirectionsButtonTapped(_ sender: Any) {
        RecipeController.shared.fetchDirections(for: recipe!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let directions):
                    if let url = URL(string: "\(directions)") {
                        UIApplication.shared.canOpenURL(url)
                        
                        UIApplication.shared.open(url, options: [:], completionHandler:nil)
                    }
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func addToRecipeBookButtonTapped(_ sender: Any) {
    }
}//End of Class

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recipeIngredientsListTV {
            guard let recipe = recipe else { return 0}
            return recipe.ingredients.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListTV", for: indexPath)
        let ingredient = recipe!.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}


