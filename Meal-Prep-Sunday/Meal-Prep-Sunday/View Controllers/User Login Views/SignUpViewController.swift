//
//  SignUpViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 5/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    private let db = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    private func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            reEnterPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            errorLabel.isHidden = false
            print(error!)
            return
        } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //            let reEnter = reEnterPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print(error, "There was an error creating the user.")
                } else {
                    self.db.collection("users").addDocument(data: ["email" : email, "password" : password, "uid" : result!.user.uid]) { (error) in
                        if let error = error {
                            print(error, "Error saving user data")
                            return
                        }
                        self.transitionToHome()
                    }
                }
            }
        }
    }
    
    private func transitionToHome() {
        performSegue(withIdentifier: "toTabBarController", sender: self)
    }
}
