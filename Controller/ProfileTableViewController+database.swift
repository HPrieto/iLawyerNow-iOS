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
    func updateProfile(image: UIImage) {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        // randomly generate unique image key id
//        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(user.uid).png")
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error.debugDescription)
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
        FIRDatabase.database().reference().child("users").child(uid).setValue(data) { (error, ref) in
            if error != nil {
                print("Unable to update profile...")
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getImageFromURL(url: URL) -> UIImage {
        var image = UIImage(contentsOfFile: "")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            DispatchQueue.main.async {
                if let imageData = data {
                    image = UIImage(data: imageData)
                }
            }
        }
        return image!
    }
}
