//
//  EditLoginInfoViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditLoginInfoViewController: UIViewController {
    
    @IBOutlet weak var editEmailTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    @IBOutlet weak var reEnterPassTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let password = editPasswordTextField.text else {return}
        guard let email = editEmailTextField.text else {return}
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            if let error = error {
                print(error, error.localizedDescription)
            }
        })
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
            if let error = error {
                print(error, error.localizedDescription)
            }
        })
    }
}
