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
        var selectedImageFromPicker: UIImage?
        
        // Get either edited image or full sized image
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.addPhotoButton.setImage(selectedImage, for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToDatabase(image: UIImage) {
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                guard let user = FIRAuth.auth()?.currentUser else {
                    return
                }
                if let imageURL = metadata?.downloadURL()?.absoluteString {
                    var profileInfo = [String:Any]()
                    profileInfo["imageURL"] = imageURL
                    if let street = self.streetAddressField.text {
                        profileInfo["street"] = street
                    }
                    if let city = self.cityField.text {
                        profileInfo["city"] = city
                    }
                    if let state = self.stateField.text {
                        profileInfo["state"] = state
                    }
                    if let zip = self.zipCodeField.text {
                        profileInfo["zip"] = zip
                    }
                    self.saveProfile(uid: user.uid, data: profileInfo)
                }
            })
        }
    }
    
    func saveProfile(uid: String, data: [String: Any]) {
        FIRDatabase.database().reference().child("users").setValue(data, forKey: uid)
    }
    
    /* Called when user cancels picking an image from UIImagePickerController */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image picker cancelled...")
        dismiss(animated: true, completion: nil)
    }
    
    /* Right NavigationButton Handler */
    @objc func rightBarButtonItemClicked() {
        print("Next Button Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    
    /* UITextField handlers for street, city, state, zip */
    @objc func handleStreet(textField: UITextField) {
        guard let street = self.streetAddressField.text else {
            return
        }
        if self.regexValidation(string: street, regEx: "") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func handleCity(textField: UITextField) {
        guard let city = self.cityField.text else {
            return
        }
        if self.regexValidation(string: city, regEx: "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func handleState(textField: UITextField) {
        guard let state = self.stateField.text else {
            return
        }
        if self.regexValidation(string: state, regEx: "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    @objc func handleZip(textField: UITextField) {
        guard let zip = self.zipCodeField.text else {
            return
        }
        if self.regexValidation(string: zip, regEx: "(?:(\\+\\d\\d\\s+)?((?:\\(\\d\\d\\)|\\d\\d)\\s+)?)(\\d{4,5}\\-?\\d{4})") {
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
