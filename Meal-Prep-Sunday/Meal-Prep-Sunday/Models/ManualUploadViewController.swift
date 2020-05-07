//
//  ManualUploadViewController.swift
//  Meal-Prep-Sunday
//
//  Created by Kelsey Sparkman on 5/5/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

struct CellData {
    let number: String?
    let message: String?
}

class ManualUploadViewController: UIViewController {
    
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
    
    weak var delegate: ManualUploadViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        directionsTextView.layer.borderWidth = 0.8
        directionsTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        data = [CellData.init(number: "2", message: "heads of broccoli")]
        
        ingredientListTableView.register(CustomCell.self, forCellReuseIdentifier: "ingredientCell")
    }
    
    @IBAction func leftPhotoButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerController.SourceType.photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true)
    }
    
    @IBAction func middlePhotoButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerController.SourceType.photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true)
    }
    
    @IBAction func rightPhotoButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerController.SourceType.photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true)
    }
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
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
    
extension ManualUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            picker.dismiss(animated: true, completion: nil)
            
            if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                leftPhotoButton.setTitle("", for: .normal)
                leftPhotoImageView.image = photo
                delegate?.ManualUploadViewControllerSelected(image: photo)
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        func presentImagePickerActionSheet() {
            
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            
            let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                    
                    imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                    
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
            }
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                    
                    imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                    
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
            }
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(actionSheet, animated: true)
        }
    
        
}
protocol ManualUploadViewControllerDelegate: class {
    func ManualUploadViewControllerSelected(image: UIImage)
}
