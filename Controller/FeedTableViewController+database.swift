//
//  FeedTableViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension FeedTableViewController {
    /* Handle user login status */
    func checkIfUserIsLoggedIn() {
        guard let user = FIRAuth.auth()?.currentUser else {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            return
        }
        self.setNavigationTitle(uid: user.uid)
    }
    
    func setNavigationTitle(uid: String) {
        FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                guard let firstName = dictionary["first_name"] as? String else {
                    return
                }
                self.navigationItem.title = "\(firstName)"
            }
        })
    }
    
    /* Pushes to LoginSignupViewController */
    @objc func handleLogout() {
        self.navigationController?.pushViewController(LoginSignupController(), animated: false)
    }
    
    func setProfileImage() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        print("Getting profile image...")
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            if let imageURL = dictionary["image_url"] as? String {
                print("image url: \(imageURL)")
                self.setProfileImageFromUrlString(urlString: imageURL)
            }
        }, withCancel: nil)
    }
    
    /* Gets and sets image from urlstring */
    func setProfileImageFromUrlString(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
            if let imageData = data {
                let image = UIImage(data: imageData)
                let imageView = UIImageView(image: image)
                imageView.layer.cornerRadius = 15
                imageView.layer.masksToBounds = true
                imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
            }
        }
    }
}
