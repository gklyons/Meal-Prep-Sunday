//
//  RecipeController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 4/28/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import Firebase

class RecipeController {
    
    static let shared = RecipeController()
    var savedRecipes: [Recipe] = []
    var uploadedRecipes: [UploadedRecipe] = []
    var recipes: [Recipe] = []
    
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
    
//    func fetchUploadRecipeImage(for uploadRecipe: UploadedRecipe, completion: @escaping (Result<UIImage, RecipeError>) -> Void) {
//        guard let uploadRecipeImage = uploadRecipe.image else {
//            return completion(.failure(.noData)) }
//        print("Um... did you even add an image to your own recipe?")
//        
//        URLSession.shared.dataTask(with: uploadRecipeImage) { (data, response, error) in
//            if let error = error {
//                completion(.failure(.thrown(error)))
//            }
//            guard let data = data else {
//                return completion(.failure(.noData))
//            }
//            guard let image = UIImage(data: data) else {
//                return completion(.failure(.noData))
//            }
//            completion(.success(image))
//        }.resume()
//        
//    }
    
    
//    func createUploadedRecipe(recipeName: String) {
////        guard let userUid = Auth.auth().currentUser?.uid else {return}
////        let image = String
//        let uploadedRecipe = UploadedRecipe(image: "image", title: "title", manualIngredients: [], directions: "directions")
//        uploadedRecipes.append(uploadedRecipe)
//        FirebaseStuff.shared.saveUploadedRecipe(uploadedRecipe: uploadedRecipe, completion: uploadedRecipe)
//    }


}//End of Class
