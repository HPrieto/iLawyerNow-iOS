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
        if let user = FIRAuth.auth()?.currentUser {
            FIRDatabase.database().reference().child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:Any] {
                    // Get user's first name
                    if let firstName = dictionary["firstName"] as? String {
                        self.profileNameLabel.text = firstName
                    } else {
                        self.profileNameLabel.text = "Edit Profile"
                    }
                    // Get user's profile image
                    if let imageURL = dictionary["imageURL"] as? String {
                        print("ImageView url: \(imageURL)")
                        self.setImageFromURL(urlString: imageURL)
                    }
                }
            })
        } else {
            self.profileNameLabel.text = "Edit Profile"
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
                self.profileNameImage.image = image
            }
        }
    }
}