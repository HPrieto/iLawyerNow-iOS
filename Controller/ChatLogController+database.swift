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
        newMessageRef = FIRDatabase.database().reference().child("messages").child(threadId)
        newMessageRef?.observe(.childAdded, with: {(snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            print("New Thread Added: \(dictionary)\n\n")
            self.addObservedMessages(dictionary)
        }, withCancel: nil)
    }
    
    func getThread() {
        guard let threadId = self.chatThread?.threadId else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        print("Get Thread: \(threadId)")
        let threadRef = FIRDatabase.database().reference().child("messages").child(threadId)
        threadRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                return
            }
            self.addMessagesToThread(dictionary)
        }
    }
    
    func addObservedMessages(_ messageThread: [String:AnyObject]) {
        for (replyId, observedMessage) in messageThread {
            print("ID: \(replyId)")
            print("Message: \(observedMessage)\n\n")
            if let message = observedMessage as? [String:AnyObject] {
                let newMessage = Message(dictionary: message)
                self.addMessageToThread(message: newMessage, id: replyId)
            }
        }
    }
    
    func addMessagesToThread(_ messageThread: [String:AnyObject]) {
        guard let thread = messageThread["thread"] as? [String:AnyObject] else {
            print("No thread exists.")
            return
        }
        for (replyId, reply) in thread {
            let message = Message(dictionary: reply as! [String:Any])
            self.addMessageToThread(message: message, id: replyId)
        }
    }
    
    func addMessageToThread(message:Message,id:String) {
        if self.messagesDictionary[id] == nil {
            self.messages.append(message)
        }
        self.messagesDictionary[id] = message
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
