//
//  ManualUploadViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/5/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class ManualUploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var leftPhotoImageView: UIImageView!
    @IBOutlet weak var leftPhotoButton: UIButton!
    @IBOutlet weak var middlePhotoImageView: UIImageView!
    @IBOutlet weak var middlePhotoButton: UIButton!
    @IBOutlet weak var rightPhotoImageView: UIImageView!
    @IBOutlet weak var rightPhotoButton: UIButton!
    @IBOutlet weak var addNewIngredientButton: UIButton!
    @IBOutlet weak var saveRecipeButton: UIButton!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var directionsTextView: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        directionsTextView.layer.borderWidth = 0.8
        directionsTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    
    
    @IBAction func leftPhotoButtonTapped(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    @IBAction func middlePhotoButtonTapped(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    @IBAction func rightPhotoButtonTapped(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            leftPhotoButton.setTitle("", for: .normal)
            leftPhotoImageView.image = photo
//            middlePhotoButton.setTitle("", for: .normal)
//            middlePhotoImageView.image = photo
//            rightPhotoButton.setTitle("", for: .normal)
//            rightPhotoImageView.image = photo
        }
        picker.dismiss(animated: true, completion: nil)
    }

}//End of Class

//extension ManualUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
//}
