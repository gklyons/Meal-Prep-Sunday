//
//  ContactUsViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/13/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
        override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
    }
}
