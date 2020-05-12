//
//  RecipeDetailViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 5/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeCookTime: UILabel!
    @IBOutlet weak var recipeIngredients: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func seeDirectionsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addToRecipeBookButtonTapped(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
