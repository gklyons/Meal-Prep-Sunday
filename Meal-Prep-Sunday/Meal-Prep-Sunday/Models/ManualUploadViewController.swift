//
//  ManualUploadViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/5/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

struct CellData {
    let number: String?
    let message: String?
}

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
    @IBOutlet weak var ingredientListTableView: UITableView!
    
    var data = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        directionsTextView.layer.borderWidth = 0.8
        directionsTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        data = [CellData.init(number: "2", message: "heads of broccoli")]
        
        ingredientListTableView.register(CustomCell.self, forCellReuseIdentifier: "ingredientCell")
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
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
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

extension ManualUploadViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientListTableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! CustomCell
        cell.message = data[indexPath.row].message
        cell.number = data[indexPath.row].number
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
}
