//
//  FirebaseStuff.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 4/29/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation
import Firebase

class FirebaseStuff {
    
    static let shared = FirebaseStuff()
    let db = Firestore.firestore()
    
    
    func signup(email: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false, error)
                return
            }
            guard let user = user else {return}
            let currentUser = Auth.auth().currentUser;
            print(" User Created \(user)")
            let values = ["email" : email, "uid" : currentUser?.uid]
            self.db.collection("users").document(currentUser!.uid).setData(values as [String : Any])
            completion(true,nil)
            print("Saved user to database")
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false)
                return
            }
            completion(true)
            return
        }
    }
    
    func saveRecipes(recipes: Recipe) {
        let ingredients = recipes.ingredients.compactMap( { Ingredient(item: $0) })
        guard let uploadedRecipe = UploadedRecipe(recipe: recipes, ingredients: ingredients) else { return }
        for ingredient in ingredients {
            ingredient.recipeRefrence = uploadedRecipe.uid
            
            let ingredientRefrence: [String: Any] = ["item" : ingredient.item, "isChecked" : ingredient.isChecked, "recipeRefrence" : ingredient.recipeRefrence]
            db.collection("ingredientsContainer").document(ingredient.uid).setData(ingredientRefrence)
        }
        let recipeRefrence: [String: Any] = ["title" : uploadedRecipe.title, "image" : uploadedRecipe.image,
                                             "directions" : uploadedRecipe.directions, "uid": uploadedRecipe.uid]
        db.collection("recipesContainer").document(uploadedRecipe.uid).setData(recipeRefrence)
    }
    
    func saveUploadedRecipes(uploadedRecipes: UploadedRecipe) {
        let uploadedRecipeRefrence: [String: Any] = ["title" : uploadedRecipes.title, "image" : uploadedRecipes.image,
                                                     "directions" : uploadedRecipes.directions, "uid": uploadedRecipes.uid]
        for ingredient in uploadedRecipes.manualIngredients {
            
            let ingredientRefrence: [String: Any] = ["item" : ingredient.item, "isChecked" : ingredient.isChecked, "recipeRefrence" : ingredient.recipeRefrence]
            db.collection("ingredientsContainer").document(ingredient.uid).setData(ingredientRefrence)
        }
        db.collection("uploadedRecipesContainer").document(uploadedRecipes.uid).setData(uploadedRecipeRefrence)
    }
    
    func pullRecipes(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser?.uid else { return }
        db.collection("recipesContainer").whereField("recipes", arrayContains: user as Any).getDocuments { (querySnapshots, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                completion(false)
            } else {
                for documents in querySnapshots!.documents {
                    //TODO: - change to uploaded recipe and refactor
                    let recipes = Recipe(label: (documents.data()["label"] as! String), image: (documents.data()["image"] as! String?), directions: (documents.data()["directions"] as! String), ingredients: (documents.data()["ingredients"] as! [String]), yield: (documents.data()["yield"] as! Int), totalTime: (documents.data()["totalTime"] as! Int))
                    
                    RecipeController.shared.recipes.append(recipes)
                }
                completion(true)
            }
        }
    }
    
    func pullUploadedRecipes(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser?.uid else { return }
        db.collection("uploadedRecipesContainer").whereField("uploadedRecipes", arrayContains: user as Any).getDocuments { (querySnapshots, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                completion(false)
            } else {
                for documents in querySnapshots!.documents {
                    let uploadedRecipes = UploadedRecipe(image: (documents.data()["image"] as! UIImage?), title: (documents.data()["title"] as! String), manualIngredients: (documents.data()["ingredients"] as! [Ingredient]), directions: (documents.data()["directions"] as! String?), uid: (documents.data()["uid"] as! String))
                    
                    RecipeController.shared.uploadedRecipes.append(uploadedRecipes)
                }
                completion(true)
            }
        }
        
        func fetchIngredientsForRecipe(recipe: Recipe, completion: @escaping ([Ingredient]?) -> Void) {
            //wherefield recipeRef = recipe.uid
        }
    }
}// End of Class
