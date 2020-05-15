//
//  PastMealPlanTableViewCell.swift
//  Meal-Prep-Sunday
//
//  Created by Jake Haslam on 5/14/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class MealPlanTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var mealPlan: MealPlan?
    
    // MARK: - Outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func populateCells(mealPlan: MealPlan) {
        
    }
}
