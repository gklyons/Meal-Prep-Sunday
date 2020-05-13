//
//  Utilities.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
