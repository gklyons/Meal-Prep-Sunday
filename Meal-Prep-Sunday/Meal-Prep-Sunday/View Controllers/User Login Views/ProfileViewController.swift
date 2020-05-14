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
    
    @IBOutlet weak var editLoginButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editLoginButton.layer.borderWidth = 0.8
        contactUsButton.layer.borderWidth = 0.8
        shareButton.layer.borderWidth = 0.8
        logOutButton.layer.borderWidth = 0.8
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
