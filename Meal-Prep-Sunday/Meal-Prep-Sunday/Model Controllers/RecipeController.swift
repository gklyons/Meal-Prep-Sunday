//
//  RecipeController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 4/28/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class RecipeController {
    
    static let shared = RecipeController()
    var recipes: [Recipe] = []
    var manualRecipes: [ManualRecipe] = []
    
//    private init() {
//    }
    
    let baseURL = URL(string: "https://api.edamam.com/search")
    let appIDName = "app_id"
    let appIDValue = "588a82d8"
    let appKeyName = "app_key"
    let appkeyValue = "0feeff9a72c76b85b082a864b382df64"
    let searchKey = "q"
    
    func fetchRecipes(searchTerm: String, completion: @escaping (Result<[Recipe], RecipeError>) -> Void) {
        ///1) URL
        guard let baseURL = baseURL else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: appIDName, value: appIDValue),
                                     URLQueryItem(name: appKeyName, value: appkeyValue),
                                     URLQueryItem(name: searchKey, value: searchTerm)]
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        ///2) DataTask
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            do {
                let recipeContainer = try JSONDecoder().decode(TopLevelObject.self, from: data).hits
                let recipes = recipeContainer.compactMap({$0.recipe})
                self.recipes = recipes
                return completion(.success(recipes))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.noData))
            }
        }.resume()
    }
    
    func fetchImage(for recipe: Recipe, completion: @escaping (Result<UIImage, RecipeError>) -> Void) {
        guard let recipeImage = URL(string: recipe.image!) else {
            return completion(.failure(.noData)) }
            print("The image is good at hide & seek! I can't find it!!")
        
        URLSession.shared.dataTask(with: recipeImage) { (data, response, error) in
            if let error = error {
                completion(.failure(.thrown(error)))
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            guard let image = UIImage(data: data) else {
                return completion(.failure(.noData))
            }
            completion(.success(image))
        }.resume()
    }
    
    func createManualRecipe(image: UIImage?, title: String, manualIngredient: String, directions: String?) {
        let manualRecipe = ManualRecipe(image: image, title: title, manualIngredient: manualIngredient, directions: directions)
        manualRecipes.append(manualRecipe)
    }
    
    
}//End of Class
