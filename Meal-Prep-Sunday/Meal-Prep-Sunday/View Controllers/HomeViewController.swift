//
//  HomeViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 5/8/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var recentTableView: UITableView!
    @IBOutlet weak var lastRecipeSavedImage: UIImageView!
    @IBOutlet weak var lastRecipeSavedName: UILabel!
    @IBOutlet weak var lastRecipeSavedCookTime: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBActions
    @IBAction func searchButtonTapped(_ sender: Any) {
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeDetailVC" {
            
        }
    }
}//End of Class

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeController.shared.recipes.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentRecipeCell", for: indexPath)
        let recipeList = RecipeController.shared.recipes
        let songCount = recipeList.count ?? 0
        
        
        
        return cell
    }
}
