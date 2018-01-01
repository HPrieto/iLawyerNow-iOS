//
//  AccountTableViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension AccountTableViewController {
    /* Retrieves user's firstname from firebase and sets it to profile cell textlabel */
    func setUserProfileName() {
        if let user = Auth.auth().currentUser {
            Database.database().reference().child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:Any] {
                    // Get user's first name
                    if let firstName = dictionary["first_name"] as? String {
                        self.profileNameLabel.text = firstName
                    } else {
                        self.profileNameLabel.text = "Edit Profile"
                    }
                    // Get user's profile image
                    if let imageURL = dictionary["image_url"] as? String {
                        print("ImageView url: \(imageURL)")
                        self.setImageFromURL(urlString: imageURL)
                    }
                }
            })
        } else {
            self.profileNameLabel.text = "Edit Profile"
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        self.navigationController?.pushViewController(LoginSignupController(), animated: false)
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
                self.profileNameImage.image = image
            }
        }
    }
}
