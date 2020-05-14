//
//  MealPlanViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class MealPlanViewController: UIViewController, UITableViewDataSource {
    
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var startNewMealPlanButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func startNewMealPlanButtonTapped(_ sender: Any) {
   
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
} // End of Class
