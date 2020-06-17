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
    
    func saveRecipe(recipe: Recipe) {
        let ingredients = recipe.ingredients.compactMap( { Ingredient(item: $0) })
        let recipeUID = UUID().uuidString
        let recipeDictionary: [String: Any] = ["title" : recipe.label,
                                               "image" : recipe.image ?? "",
                                               "directions" : recipe.directions,
                                               "yield" : recipe.yield,
                                               "totalTime" : recipe.totalTime,
                                               "uid": recipeUID]
        for ingredient in ingredients {
            saveIngredient(ingredient: ingredient, recipeUID: recipeUID)
        }
        db.collection("savedRecipesContainer").document(recipeUID).setData(recipeDictionary)
    }
    
    func saveIngredient(ingredient: Ingredient, recipeUID: String) {
        ingredient.recipeRefrence = recipeUID
        let ingredientRefrence: [String: Any] = ["item" : ingredient.item,
                                                 "isChecked" : ingredient.isChecked,
                                                 "recipeRefrence" : ingredient.recipeRefrence ?? ""]
        db.collection("ingredientsContainer").document(ingredient.uid).setData(ingredientRefrence)
    }
    
    func saveUploadedRecipe(uploadedRecipe: UploadedRecipe) {
        let ingredients = uploadedRecipe.manualIngredients.compactMap( { Ingredient(item: $0.item) })
        let recipeUID = UUID().uuidString
        uploadPhoto(image: uploadedRecipe.image) { (imageEndpoint) in
            let recipeDictionary: [String: Any] = ["title" : uploadedRecipe.label,
                                                   "imageEndpoint" : imageEndpoint ?? "",
                                                   "directions" : uploadedRecipe.directions ?? [],
                                                   "uid": recipeUID]
            for ingredient in ingredients {
                self.saveIngredient(ingredient: ingredient, recipeUID: recipeUID)
            }
            self.db.collection("uploadRecipesContainer").document(recipeUID).setData(recipeDictionary)
        }
        //        let imageURL = uploadPhoto(image: uploadedRecipes.image) { (imageURL) in
        //            let uploadedRecipeRefrence: [String: Any] = ["title" : uploadedRecipes.title,
        //                                                         "imageURL" : imageURL,
        //                                                         "directions" : uploadedRecipes.directions,
        //                                                         "uid": uploadedRecipes.uid]
        //            for ingredient in uploadedRecipes.manualIngredients {
        //                let ingredientRefrence: [String: Any] = ["item" : ingredient.item,
        //                                                         "isChecked" : ingredient.isChecked,
        //                                                         "recipeRefrence" : ingredient.recipeRefrence]
        //                self.db.collection("ingredientsContainer").document(ingredient.uid).setData(ingredientRefrence)
        //            }
        //            self.db.collection("uploadedRecipesContainer").document(uploadedRecipes.uid).setData(uploadedRecipeRefrence)
        //        }
    }
    
    func getSavedRecipeCollection() {
        RecipeController.shared.savedRecipes = []
        db.collection("savedRecipesContainer").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                //Do try catch
                for document in querySnapshot!.documents {
                    let recipe = Recipe(label: (document.data()["title"] as? String ?? ""),
                                        image: (document.data()["image"] as? String ?? ""),
                                        directions: (document.data()["directions"] as? String ?? ""),
                                        ingredients: (document.data()["ingredients"] as? [String] ?? []),
                                        yield: (document.data()["yield"] as? Int ?? 0),
                                        totalTime: (document.data()["totalTime"] as? Int ?? 0),
                                        users: (document.data()["users"] as? [String] ?? []),
                                        uid: (document.data()["uid"] as? String ?? ""))
                    
                    RecipeController.shared.savedRecipes.append(recipe)
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func getUploadRecipeCollection() {
        RecipeController.shared.uploadedRecipes = []
        db.collection("uploadRecipesContainer").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let uploadRecipe = UploadedRecipe(image: nil,
                                                      title: (document.data()["title"] as? String ?? ""),
                                                      manualIngredients: (document.data()["manualIngredients"] as? [Ingredient] ?? []),
                                                      directions: (document.data()["directions"] as? String ?? ""),
                                                      uid: (document.data()["uid"] as? String ?? ""),
                                                      imageEndpoint: (document.data()["imageEndpoint"] as? String ?? ""))
                    
                    RecipeController.shared.uploadedRecipes.append(uploadRecipe)
                }
            }
        }
    }
    
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
        guard let image = image,
            let data = image.jpegData(compressionQuality: 1.0)
            else {
                print("error!")
                return completion(nil)
        }
        var imageEndpoint: String? = nil
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
                imageEndpoint = url.absoluteString
                dispatchGroup.leave()
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            return completion(imageEndpoint)
        }
    }
}// End of Class
