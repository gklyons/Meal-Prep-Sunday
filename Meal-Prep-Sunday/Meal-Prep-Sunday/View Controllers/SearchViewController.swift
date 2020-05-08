//
//  SearchViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/7/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    

    @IBOutlet weak var recipeSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTableView.separatorStyle = .none
        recipeSearchBar.delegate = self
        searchResultsTableView.rowHeight = 100
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? SearchViewTableViewCell else {return UITableViewCell()}
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = recipeSearchBar.text, !searchTerm.isEmpty else {return}
        RecipeController.shared.fetchRecipes(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self.recipes = recipes
                    self.searchResultsTableView.reloadData()
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
