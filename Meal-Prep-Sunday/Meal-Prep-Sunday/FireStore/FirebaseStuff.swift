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
    
    func saveRecipe(recipe: Recipe, completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser?.uid else { return }
        db.collection("Recipes").whereField("users", arrayContains: user as Any).getDocuments() { (querySnapshots, error) in if let error = error {
            print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
            completion(false)
        } else {
            for documents in querySnapshots!.documents {
                
                let recipe = Recipe(label: documents.data()["label"] as! String, image: documents.data()["image"] as! String?, directions: documents.data()["directions"] as! String, ingredients: documents.data()["ingrediants"] as! [String], yield: documents.data()["yield"] as! Int, totalTime: documents.data()["totalTime"] as! Int)
                
                RecipeController.shared.recipes.append(recipe)
            }
            completion(true)
            }
        }
    }
    
    func saveUploadedRecipe(uploadedRecipe: UploadedRecipe) {
        let values: [String : Any] = ["image" : uploadedRecipe.image as Any, "title" : uploadedRecipe.title, "users" : [uploadedRecipe.users], "uid" : uploadedRecipe.uid, "directions" : uploadedRecipe.directions as Any, "manualIngredients" : uploadedRecipe.manualIngredients]
               db.collection("Uploaded Recipes").document(uploadedRecipe.uid).setData(values)
    }
    
}//End of Class
