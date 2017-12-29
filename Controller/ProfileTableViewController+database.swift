//
//  ProfileTableViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension ProfileTableViewController {
    /* Retrieves user's profile from database and sets to fields */
    func getUserProfile() {
        if let user = FIRAuth.auth()?.currentUser {
            self.emailLabel.text = user.email
            FIRDatabase.database().reference().child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    if let firstName = dictionary["first_name"],
                        let lastName  = dictionary["last_name"] {
                        self.fullNameLabel.text = "\(firstName) \(lastName)"
                    } else {
                        self.fullNameLabel.text = "User"
                    }
                    if let imageUrl = dictionary["image_url"] as? String {
                        print("There is a url")
                        self.setImageFromURL(urlString: imageUrl)
                    } else {
                        print("There is no url")
                    }
                    if let street = dictionary["street"] as? String {
                        self.streetAddressField.text = street
                    }
                    if let city = dictionary["city"] as? String {
                        self.cityField.text = city
                    }
                    if let state = dictionary["state"] as? String {
                        self.stateField.text = state
                    }
                    if let zip = dictionary["zip"] as? String {
                        self.zipCodeField.text = zip
                    }
                }
            })
        } else {
            
        }
    }
    
    func updateProfileWithImage(image: UIImage) {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(user.uid).png")
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                if let imageURL = metadata?.downloadURL()?.absoluteString {
                    var profileInfo = [String:Any]()
                    profileInfo["image_url"] = imageURL
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
    
    /* Saves user's profile given data dictionary */
    func saveProfile(uid: String, data: [String: Any]) {
        FIRDatabase.database().reference().child("users").child(uid).updateChildValues(data) { (error, ref) in
            if error != nil {
                print("Unable to update profile...")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /* Saves user's profile */
    func saveProfile() {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        var profileInfo = [String:Any]()
        if let street = self.streetAddressField.text {
            if street.underestimatedCount > 0 {
                profileInfo["street"] = street
            }
        }
        if let city = self.cityField.text {
            if city.underestimatedCount > 0 {
                profileInfo["city"] = city
            }
        }
        if let state = self.stateField.text {
            if state.underestimatedCount > 0 {
                profileInfo["state"] = state
            }
        }
        if let zip = self.zipCodeField.text {
            if zip.underestimatedCount > 0 {
                profileInfo["zip"] = zip
            }
        }
        self.saveProfile(uid: user.uid, data: profileInfo)
    }
    
    /* Updates user's profile with validated input values and image */
    func updateProfile() {
        if self.validFields() {
            if let profileImage = self.selectedImageFromPicker {
                print("User did select an image to upload...")
                self.updateProfileWithImage(image: profileImage)
            } else {
                print("User did not select an image to upload...")
                self.saveProfile()
            }
        }
    }
    
    /* Gets and sets image from urlstring */
    func setImageFromURL(urlString: String) {
        print("Setting image from url...")
        print(urlString)
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.addPhotoButton.setImage(image, for: .normal)
            }
        }
    }
}

/*
 URLSession.shared.dataTask(with: url) { (data, response, error) in
 print("inside setting image...")
 if error != nil {
 print(error.debugDescription)
 return
 }
 print("There was no error in session...")
 DispatchQueue.main.async {
 if let imageData = data {
 print("Setting image...")
 self.addPhotoButton.setImage(UIImage(data: imageData), for: .normal)
 }
 }
 }
 
 */
