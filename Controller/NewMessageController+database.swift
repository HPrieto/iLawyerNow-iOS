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
    func observeMessages() {
        print("NewMessage Observing Messages...")
        //guard let uid = FIRAuth.auth()?.currentUser?.uid else {
        //    return
        //}
        let newMessageRef = Database.database().reference().child("messages")
        newMessageRef.observe(.childAdded, with: {(snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            // Create new Message Object
            let message = Message(dictionary: dictionary)
            
            // Add new message to messages map
            self.messages.append(message)
            
            // Reload TableView with new messages
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
        }, withCancel: nil)
    }
    
    func sendMessage() {
        guard let user = Auth.auth().currentUser else {
            print("NewMessage: Unable to send message, no user logged in.")
            return
        }
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let timestamp = Double(Date().timeIntervalSince1970)
        let values = ["post": self.messageTextField.text!,
                      "from_id": user.uid,
                      "timestamp": timestamp] as [String : Any]
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
                print("image url: \(imageURL)")
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

