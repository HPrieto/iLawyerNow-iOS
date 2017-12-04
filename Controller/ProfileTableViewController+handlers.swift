//
//  ProfileTableViewController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /* AddPhoto Button Handler */
    @objc func handleAddPhotoButtonClick() {
        print("Adding photo...")
        self.view.endEditing(true)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    /* Called when user picks an image from UIImagePickerController */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get either edited image or full sized image
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.addPhotoButton.setImage(selectedImage, for: .normal)
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    /* Called when user cancels picking an image from UIImagePickerController */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image picker cancelled...")
        dismiss(animated: true, completion: nil)
    }
    
    /* Right NavigationButton Handler */
    @objc func rightBarButtonItemClicked() {
        print("Next Button Clicked")
        self.updateProfile()
    }
    
    // Checks for valid input fields
    func validFields() -> Bool {
        if let street = self.streetAddressField.text {
            if street.underestimatedCount > 30 {
                print("Invalid street: \(street)")
                return false
            }
        }
        if let city = self.cityField.text {
            if !self.regexValidation(string: city, regEx: "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)")
                && city.underestimatedCount != 0 {
                print("Invalid city: \(city)")
                return false
            }
        }
        if let state = self.stateField.text {
            if !self.regexValidation(string: state, regEx: "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)")
                && state.underestimatedCount != 0 {
                print("Invalid street: \(state)")
                return false
            }
        }
        if let zip = self.zipCodeField.text {
            if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: zip))
                && zip.underestimatedCount != 0 {
                print("Invalid zip: \(zip)")
                return false
            }
        }
        return true
    }
    
    /* UITextField handlers for street, city, state, zip */
    @objc func handleFields() {
        if self.validFields() {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    /* Not a handler but whatevs */
    func regexValidation(string: String, regEx: String) -> Bool {
        var returnValue = true
        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
}
