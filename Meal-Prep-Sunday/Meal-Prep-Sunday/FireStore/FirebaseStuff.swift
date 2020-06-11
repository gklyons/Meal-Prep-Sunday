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
        let imageURL = uploadPhoto(image: uploadedRecipe.image) { (imageURL) in
            let recipeDictionary: [String: Any] = ["title" : uploadedRecipe.label,
                                                   "image" : imageURL ?? "",
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
    
    func getRecipeCollection() {
        db.collection("recipesContainer").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                //Do try catch
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
    
    func pullSavedRecipes(completion: @escaping (Bool) -> Void) {
        
        
        //            guard let user = Auth.auth().currentUser?.uid else { return }
        //            db.collection("recipesContainer").whereField("users", arrayContains: user as Any).getDocuments { (querySnapshots, error) in
        //                if let error = error {
        //                    print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
        //                    completion(false)
        //                } else {
        //                    let group = DispatchGroup()
        //                    for documents in querySnapshots!.documents {
        //                        group.enter()
        //                        //TODO: - change to uploaded recipe and refactor
        //                        let recipe = Recipe(label: ((documents.data()["label"] as! String)), image: (documents.data()["image"] as! String), directions: (documents.data()["directions"] as! String), ingredients: (documents.data()["ingredients"] as! [String]), yield: (documents.data()["yield"] as! Int), totalTime: (documents.data()["totalTime"] as! Int), users: (documents.data()["users"] as! [String]), uid: (documents.data()["uid"] as! String))
        //                        group.leave()
        //                        RecipeController.shared.savedRecipes.append(recipe)
        //                    }
        //                    group.notify(queue: .main) {
        //                        completion(true)
        //                    }
        //                }
        //            }
    }
    
    //    func pullBubbles(completion: @escaping (Bool) -> Void){
    //        guard let user = Auth.auth().currentUser?.uid else {return}
    //        db.collection("BubbleRooms").whereField("users", arrayContains: user as Any).getDocuments() { (querySnapshots, error) in
    //            if let error = error{
    //                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
    //                completion(false)
    //            } else {
    //                for documents in querySnapshots!.documents {
    //
    //                    let bubble = Bubble(lastChanged: (documents.data()["lastChanged"] as! Timestamp).dateValue(), projectName: documents.data()["projectName"] as! String, bubbles: documents.data()["bubbles"] as! [String], users: documents.data()["users"] as! [String])
    //
    //                    BubbleController.shared.bubbles.append(bubble)
    //                }
    //                completion(true)
    //            }
    //        }
    //    }
    //
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
