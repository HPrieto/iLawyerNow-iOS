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
                        self.profileNameImage.loadImageUsingCacheWithUrlString(urlString: imageURL)
                    } else {
                        self.profileNameImage.image = UIImage(named: "profile_icon")
                    }
                } else {
                    self.profileNameImage.image = UIImage(named: "profile_icon")
                }
            })
        } else {
            self.profileNameLabel.text = "Edit Profile"
            self.profileNameImage.image = UIImage(named: "profile_icon")
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
}
