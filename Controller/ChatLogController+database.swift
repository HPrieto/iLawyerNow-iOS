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
        print("ThreadID: \(threadId)")
        let newMessageRef = FIRDatabase.database().reference().child("messages").child(threadId)
        newMessageRef.observe(.childAdded, with: {(snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            print("Thread: \(dictionary)")
        }, withCancel: nil)
    }
    
    func getThread() {
        guard let threadId = self.chatThread?.threadId,
              let uid = self.chatThread?.id else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let threadRef = FIRDatabase.database().reference().child("messages").child(threadId)
        threadRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            self.addMessagesToThread(dictionary, uid: uid)
        }
    }
    
    func addMessagesToThread(_ messageThread: [String:AnyObject], uid: String) {
        guard let thread = messageThread["thread"] as? [String:AnyObject] else {
            return
        }
        print("New Thread: \(thread)")
        for (replyId, reply) in thread {
            print("Reply Id: \(replyId)")
            print("Reply:    \(reply)\n\n")
            let message = Message(dictionary: reply as! [String:Any])
            self.messages.append(message)
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
        }
    }
    
    func sendMessage() {
        guard let user = FIRAuth.auth()?.currentUser else {
            print("Unable to send message, no user logged in.")
            return
        }
        guard let threadId = self.chatThread?.threadId else {
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
