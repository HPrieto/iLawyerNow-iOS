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
    func observeThread() {
        print("ChatLog observing thread...")
        guard let threadId = self.chatThread?.threadId else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        FIRDatabase.database().reference().child("messages").child(threadId).child("thread").observe(.childAdded, with: {(snapshot) in
            guard let message = snapshot.value as? [String:AnyObject] else {
                print("Invalid message.")
                return
            }
            self.addMessageToCollection(key: snapshot.key, message: message)
        }, withCancel: nil)
    }
    
    func addMessageToCollection(key: String, message: [String:AnyObject]) {
        let newMessage = Message(dictionary: message)
        if self.messagesDictionary[key] == nil {
            self.messages.append(newMessage)
        }
        self.messagesDictionary[key] = newMessage
        self.attemptReloadOfTable()
    }
    
    func sendMessage() {
        guard let user = FIRAuth.auth()?.currentUser,
              let threadId = self.chatThread?.threadId else {
            print("Unable to send message, no user logged in.")
            return
        }
        let ref = FIRDatabase.database().reference().child("messages").child(threadId).child("thread")
        let childRef = ref.childByAutoId()
        let timestamp = Int(Date().timeIntervalSince1970)
        let values = ["post": inputTextField.text!,"from_id": user.uid, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.inputTextField.text = nil
        }
    }
    
    fileprivate func attemptReloadOfTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    func userId() -> String {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return ""
        }
        return uid
    }
    
    func userIsLoggedIn() -> Bool {
        return FIRAuth.auth()?.currentUser != nil
    }
}
