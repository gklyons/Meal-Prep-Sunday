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
    var shoppingLists: [ShoppingList] = []
    
    // Mark: - Crud Functions
    func create(ingredient: String, measurement: String) {
        let ingredient = ShoppingList(ingredient: ingredient, measurement: measurement)
        shoppingLists.append(ingredient)
        saveToPersistentStore(ingredient: shoppingLists)
    }
    
    func read() {
        
    }
    
    func update(ingredient: String, measurement: String) {
        
    }
    
    func delete(shoppingList: ShoppingList) {
        if let index = shoppingLists.firstIndex(of: shoppingList) {
        shoppingLists.remove(at: index)
            saveToPersistentStore(ingredient: shoppingLists)
        }
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "mealPrepSunday.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStore(ingredient: [ShoppingList]) {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(shoppingLists)
            try data.write(to: fileURL())
        } catch let error{
            print("\(error.localizedDescription) -> \(error)")
        }
    }
    
    func loadFromPersistence() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let shoppingListDecoded = try jsonDecoder.decode([ShoppingList].self, from: data)
            self.shoppingLists = shoppingListDecoded
        } catch let error {
            print("\(error.localizedDescription) -> \(error)")
        }
    }
    
}//End of class

