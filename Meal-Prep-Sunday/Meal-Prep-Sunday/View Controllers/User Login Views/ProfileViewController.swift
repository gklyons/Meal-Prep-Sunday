//
//  ProfileViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        transitionToSignUpScreen()
    }
    
    func transitionToSignUpScreen() {
        navigationController?.popViewController(animated: true)
    }
}
