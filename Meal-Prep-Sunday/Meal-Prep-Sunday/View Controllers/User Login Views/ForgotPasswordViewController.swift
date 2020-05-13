//
//  ForgotPasswordViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Garrett Lyons on 5/12/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, emailTextField.text != "" else {return}
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                self.showError("Error sending email. Please check email address for typo.")
            } else {
                self.showError("Password reset email sent!")
            }
        }
    }
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func returnToSignInTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
