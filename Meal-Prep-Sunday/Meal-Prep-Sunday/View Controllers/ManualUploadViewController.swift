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
    let message: String?
}

class ManualUploadViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var middlePhotoImageView: UIImageView!
    @IBOutlet weak var middlePhotoButton: UIButton!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryButtonTableView: UITableView!
    @IBOutlet weak var addNewIngredientButton: UIButton!
    @IBOutlet weak var ingredientListTableView: UITableView!
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var saveRecipeButton: UIButton!
    
    var data = [CellData]()
    
    var categories = ["Breakfast", "Lunch", "Dinner", "Dessert"]
    
    weak var delegate: ManualUploadViewControllerDelegate?
    
    var ingredientStr: String?
    
    var pickerOne: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryButtonTableView.isHidden = true
        categoryButton.layer.borderWidth = 0.8
        directionsTextView.layer.borderWidth = 0.8
        categoryButton.layer.borderColor = UIColor.lightGray.cgColor
        directionsTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func customInit(ingredientStr: String) {
        self.ingredientStr = ingredientStr
    }
    
    @IBAction func middlePhotoButtonTapped(_ sender: Any) {
        pickerOne = UIImagePickerController()
        pickerOne!.delegate = self
        presentImagePickerActionSheet()
    }
    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        if categoryButtonTableView.isHidden {
            animateCategory(toggle: true)
        } else {
            animateCategory(toggle: false)
        }
    }
    
    func animateCategory(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.categoryButtonTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.categoryButtonTableView.isHidden = true
            }
        }
    }
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new ingredient", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields![0].placeholder = "Enter an Ingredient"
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            //            let ingredientText = alert.textFields![0].text
            
            guard let item = alert.textFields?[0].text, item != "" else {return}
            
            self.ingredientListTableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        self.present(alert, animated: true)
    }
}//End of Class

extension ManualUploadViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientListTableView {
            return RecipeController.shared.manualRecipes.count
        } else if tableView == categoryButtonTableView {
            return categories.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ingredientListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            let manualIngredient = RecipeController.shared.manualRecipes[indexPath.row]
            cell.textLabel?.text = manualIngredient.manualIngredient
            return cell
        } else if tableView == categoryButtonTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
            cell.textLabel?.text = categories[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryButton.setTitle("  \(categories[indexPath.row])", for: .normal)
        animateCategory(toggle: false)
    }
    
}

extension ManualUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            middlePhotoButton.setTitle("", for: .normal)
            middlePhotoImageView.image = photo
            delegate?.ManualUploadViewControllerSelected(image: photo)
            
        }
        picker.dismiss(animated: true, completion: nil)
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
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = UIImagePickerController.SourceType.camera
            imagePickerController.allowsEditing = false
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "No Camera Access", message: "Please allow access to the camera to use this feature.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Back", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }//end of openCamera func
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "No Photo Access", message: "Please allow access to photos to use this feature.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Back", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }//end of openGallery func
    
    func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.openCamera()
                }
            }
            break
        case .restricted, .denied:
            presentDeniedAlert()
            break
        case .authorized:
            openCamera()
        @unknown default:
            print("Default case for AVCaptureDevice.authorizationStatus()")
        }
    }//end of checkCameraAuthorization func
    
    func checkPhotoLibraryAuthorization() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization( { status in
                if (status == PHAuthorizationStatus.authorized) {
                    self.openGallery()
                }
            })
            break
        case .restricted, .denied:
            presentDeniedAlert()
            break
        case .authorized:
            openGallery()
        @unknown default:
            print("Default case for AVCaptureDevice.authorizationStatus()")
        }
    }//end of checkPhotoLibraryAuthorization func
    
    func presentDeniedAlert() {
        let alert = UIAlertController(title: "Access Denied", message: "Check your permission or restriction settings and try again.", preferredStyle: .alert)
        
        let dismissButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(dismissButton)
        self.present(alert, animated: true)
    }//end of presentDeniedAlert func
    
}

protocol ManualUploadViewControllerDelegate: class {
    func ManualUploadViewControllerSelected(image: UIImage)
}
