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
    
    /* Observes database/thread in real-time */
    func observeThread() {
        print("ChatLog observing thread...")
        guard let threadId = self.chatThread?.threadId else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        Database.database().reference().child("messages").child(threadId).child("thread").observe(.childAdded, with: {(snapshot) in
            guard let message = snapshot.value as? [String:AnyObject] else {
                print("Invalid message.")
                return
            }
            self.hideLoadingView()
            self.addMessageToCollection(key: snapshot.key, message: message)
        }, withCancel: nil)
    }
    
    /* Sets initial main post the collectionView thread */
    func setUserPostToThread() {
        guard let threadId = self.chatThread?.threadId else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        Database.database().reference().child("messages").child(threadId).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let thread = snapshot.value as? [String:AnyObject] else {
                return
            }
            var post = [String:AnyObject]()
            post["from_id"] = thread["from_id"]
            post["post"] = thread["post"]
            post["timestamp"] = thread["timestamp"]
            post["name"] = thread["name"]
            self.addMessageToCollection(key: snapshot.key, message: post)
        }, withCancel: nil)
    }
    
    /* Takes in map from data, adds to collectionView */
    func addMessageToCollection(key: String, message: [String:AnyObject]) {
        let newMessage = Message(dictionary: message)
        if self.messagesDictionary[key] == nil {
            self.messages.append(newMessage)
        }
        self.messagesDictionary[key] = newMessage
        self.attemptReloadOfTable()
    }
    
    /* Saves new message to thread in database */
    func sendMessage() {
        guard let user = Auth.auth().currentUser,
              let threadId = self.chatThread?.threadId,
              let firstName = self.chatThread?.firstName,
              let lastName = self.chatThread?.lastName else {
            print("Unable to send message, no user logged in.")
            return
        }
        let ref = Database.database().reference().child("messages").child(threadId).child("thread")
        let childRef = ref.childByAutoId()
        let timestamp = Int(Date().timeIntervalSince1970)
        let values = ["post": inputTextField.text!,"from_id": user.uid, "timestamp": timestamp, "name": "\(firstName) \(lastName)"] as [String : Any]
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.inputTextField.text = nil
        }
    }
    
    /* Attempts to 'safely' reload collectionview */
    fileprivate func attemptReloadOfTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    /* Returns user's database reference unique id */
    func userId() -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            return ""
        }
        return uid
    }
    
    /* True: user is logged in, False: user is logged out */
    func userIsLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
