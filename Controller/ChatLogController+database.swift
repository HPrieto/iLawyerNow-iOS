//
//  ChatLogController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension ChatLogController {
    func observeMessages() {
        print("ChatLog Observing Messages...")
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        let newMessageRef = FIRDatabase.database().reference().child("messages")
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
        guard let user = FIRAuth.auth()?.currentUser else {
            print("Unable to send message, no user logged in.")
            return
        }
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let timestamp = Int(Date().timeIntervalSince1970)
        let values = ["text": inputTextField.text!,"from_id": user.uid, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.inputTextField.text = nil
        }
    }
}
