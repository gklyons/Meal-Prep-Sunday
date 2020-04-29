//
//  ShoppingListController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 4/27/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class ShoppingListController {
    
    // Mark: - Properties
    static let shared = ShoppingListController()
    var shoppingList: ShoppingList?
    
    // Mark: - Crud Functions
    func createList(ingredients: Ingredient) {
        shoppingList?.ingredients.append(ingredients)
        saveToPersistentStore()
    }
    
    func updateIngredient(ingredient: Ingredient, item: String) {
        ingredient.item = item
        saveToPersistentStore()
    }
    
    func deleteIngredient(ingredients: Ingredient) {
        guard let index = shoppingList?.ingredients.firstIndex(of: ingredients) else {return}
        shoppingList?.ingredients.remove(at: index)
        saveToPersistentStore()
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "mealPrepSunday.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(shoppingList)
            try data.write(to: fileURL())
        } catch let error{
            print("\(error.localizedDescription) -> \(error)")
        }
    }
    
    func loadFromPersistence() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let shoppingListDecoded = try jsonDecoder.decode(ShoppingList.self, from: data)
            self.shoppingList = shoppingListDecoded
        } catch let error {
            print("\(error.localizedDescription) -> \(error)")
        }
    }
}//End of class

