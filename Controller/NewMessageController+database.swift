//
//  NewMessageController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension NewMessageController {
    func sendMessage() {
        guard let user = Auth.auth().currentUser,
        let sendersName = self.name else {
            print("NewMessage: Unable to send message, no user logged in.")
            return
        }
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let timestamp = Double(Date().timeIntervalSince1970)
        var values = ["post": self.messageTextField.text!,
                      "from_id": user.uid,
                      "timestamp": timestamp,
                      "name": sendersName] as [String : Any]
        if self.profileImageUrl != nil {
            values["image_url"] = self.profileImageUrl
        }
        childRef.updateChildValues(values) { (error, reference) in
            if error != nil {
                print(error!)
                return
            }
            let messageAutoId = reference.key
            let userMessagesRef = Database.database().reference().child("users").child(user.uid).child("messages")
            userMessagesRef.updateChildValues([messageAutoId:timestamp])
            self.messageTextField.text = nil
        }
    }
    
    /*  */
    func setProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        print("Getting profile image...")
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            if let imageURL = dictionary["image_url"] as? String {
                self.profileImageUrl = imageURL
                let imageView = UIImageView()
                imageView.loadImageUsingCacheWithUrlString(urlString: imageURL)
                imageView.layer.cornerRadius = 15
                imageView.layer.masksToBounds = true
                imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
            } else {
                self.navigationItem.leftBarButtonItem = nil
            }
            if let firstName = dictionary["first_name"] as? String,
                let lastName = dictionary["last_name"] as? String {
                self.name = "\(firstName) \(lastName)"
            } else {
                print("Could not get user's first and last name.")
            }
        }, withCancel: nil)
    }
}

