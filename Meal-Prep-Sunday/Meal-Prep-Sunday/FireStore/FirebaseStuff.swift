//
//  FirebaseStuff.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 4/29/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class FirebaseStuff {
    
    static let shared = FirebaseStuff()
    let db = Firestore.firestore()
    
    func saveRecipes(recipes: Recipe) {
        let ingredients = recipes.ingredients.compactMap( { Ingredient(item: $0) })
        guard let uploadedRecipe = UploadedRecipe(recipe: recipes, ingredients: ingredients) else { return }
        for ingredient in ingredients {
            ingredient.recipeRefrence = uploadedRecipe.uid
            let ingredientRefrence: [String: Any] = ["item" : ingredient.item,
                                                     "isChecked" : ingredient.isChecked,
                                                     "recipeRefrence" : ingredient.recipeRefrence]
            db.collection("ingredientsContainer").document(ingredient.uid).setData(ingredientRefrence)
        }
        let recipeRefrence: [String: Any] = ["title" : uploadedRecipe.title,
                                             "image" : uploadedRecipe.image,
                                             "directions" : uploadedRecipe.directions,
                                             "uid": uploadedRecipe.uid]
        db.collection("recipesContainer").document(uploadedRecipe.uid).setData(recipeRefrence)
    }
    
    func saveUploadedRecipes(uploadedRecipes: UploadedRecipe) {
        let imageURL = uploadPhoto(image: uploadedRecipes.image) { (imageURL) in
            let uploadedRecipeRefrence: [String: Any] = ["title" : uploadedRecipes.title,
                                                         "imageURL" : imageURL,
                                                         "directions" : uploadedRecipes.directions,
                                                         "uid": uploadedRecipes.uid]
            for ingredient in uploadedRecipes.manualIngredients {
                let ingredientRefrence: [String: Any] = ["item" : ingredient.item,
                                                         "isChecked" : ingredient.isChecked,
                                                         "recipeRefrence" : ingredient.recipeRefrence]
                self.db.collection("ingredientsContainer").document(ingredient.uid).setData(ingredientRefrence)
            }
            self.db.collection("uploadedRecipesContainer").document(uploadedRecipes.uid).setData(uploadedRecipeRefrence)
        }
    }
    
    //    func pullRecipes(completion: @escaping (Bool) -> Void) {
    //        guard let user = Auth.auth().currentUser?.uid else { return }
    //        db.collection("recipesContainer").whereField("recipes", arrayContains: user as Any).getDocuments { (querySnapshots, error) in
    //            if let error = error {
    //                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
    //                completion(false)
    //            } else {
    //                for documents in querySnapshots!.documents {
    //                    //TODO: - change to uploaded recipe and refactor
    //                    guard let recipes = Recipe(label: ((documents.data()["label"] as? String)), image: (documents.data()["image"] as? String?), directions: (documents.data()["directions"] as? String), ingredients: (documents.data()["ingredients"] as? [String]), yield: (documents.data()["yield"] as? Int), totalTime: (documents.data()["totalTime"] as? Int)) else { return }
    //
    //                    RecipeController.shared.recipes.append(recipes)
    //                }
    //                completion(true)
    //            }
    //        }
    //    }
    
//    func pullUploadedRecipes(completion: @escaping (Bool) -> Void) {
//        guard let user = Auth.auth().currentUser?.uid else { return }
//        db.collection("uploadedRecipesContainer").whereField("uploadedRecipes", arrayContains: user as Any).getDocuments { (querySnapshots, error) in
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
//                completion(false)
//            } else {
//                let dispatchGroup = DispatchGroup()
//                for documents in querySnapshots!.documents {
//                    dispatchGroup.enter()
//                    //  guard let uploadedRecipes = UploadedRecipe(image: (documents.data()["image"] as? UIImage?), title: (documents.data()["title"] as? String), manualIngredients: (documents.data()["ingredients"] as? [Ingredient]), directions: (documents.data()["directions"] as? String?), uid: (documents.data()["uid"] as? String)) else { continue }
//                    fetchIngredientsForRecipe(recipe: uploadedRecipes) { (ingredient) in
//                        if let ingredient = ingredient {
//                            uploadedRecipes.manualIngredients = ingredient
//                            dispatchGroup.leave()
//                        }
//                    }
//                    RecipeController.shared.uploadedRecipes.append(uploadedRecipes)
//                }
//                dispatchGroup.notify(queue: .main) {
//                    completion(true)
//                }
//            }
//        }
//    }
    
    fileprivate func fetchIngredientsForRecipe(recipe: UploadedRecipe, completion: @escaping ([Ingredient]?) -> Void) {
        db.collection("ingredientsContainer").whereField("recipeRefrence", isEqualTo: recipe.uid).getDocuments { (querrySnapshots, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                completion(nil)
            } else {
                var ingredientArray: [Ingredient] = []
                for ingredients in querrySnapshots!.documents {
                    guard let ingredient = Ingredient(dictionary: ingredients.data()) else { continue }
                    ingredientArray.append(ingredient)
                }
                completion(ingredientArray)
            }
        }
    }
    
    fileprivate func uploadPhoto(image: UIImage?, completion: @escaping (String?) -> Void) {
        guard let image = image, let data = image.jpegData(compressionQuality: 1.0) else {
            print("error!")
            return completion(nil)
        }
        var imageURL: String? = nil
        let imageName = UUID().uuidString
        let imageRef = Storage.storage().reference().child("images").child(imageName)
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(nil)
            }
            dispatchGroup.enter()
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print(error, error.localizedDescription)
                    return completion(nil)
                }
                guard let url = url else {
                    print("Error: Something went wrong")
                    return completion(nil)
                }
                imageURL = url.absoluteString
                dispatchGroup.leave()
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            return completion(imageURL)
        }
    }
}// End of Class
