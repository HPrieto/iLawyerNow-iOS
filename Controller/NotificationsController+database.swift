//
//  NotificationsController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/26/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension NotificationsController {
    
    func userIsLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    func removeOldNotifications() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        for (key, value) in self.alertsDictionary {
            guard let fromId = value.fromId else {
                return
            }
            if fromId != uid {
                self.alertsDictionary.removeValue(forKey: key)
                self.alerts.remove(at: self.alertIndex(alert: value))
            }
        }
        self.tableView.reloadData()
    }
    
    func alertIndex(alert: Alert) -> Int {
        for index in 0...self.alerts.count {
            if self.alerts[index].threadId == alert.threadId {
                return index
            }
        }
        return -1
    }
    
    func observeNotifications() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        print("Observing notifications")
        let newMessageRef = Database.database().reference().child("users").child(uid)
        newMessageRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let userInfo = snapshot.value as? [String:Any] else {
                print("No user info found")
                return
            }
            self.hideLoadingView()
            self.setUserMessages(userInfo, uid: uid)
        }
    }
    
    func setUserMessages(_ userInfo: [String:Any], uid: String) {
        guard let messages = userInfo["messages"] as? [String:Double] else {
            print("No messages for user")
            return
        }
        for (mid, timestamp) in messages {
            let messagesRef = Database.database().reference().child("messages")
            messagesRef.child(mid).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let messageThread = snapshot.value as? [String:Any] else {
                    return
                }
                if let fromId = messageThread["from_id"] as? String,
                   let post = messageThread["post"] as? String,
                   let firstName = userInfo["first_name"] as? String,
                   let lastName = userInfo["last_name"] as? String {
                    let newAlert = Alert()
                    newAlert.threadId = mid
                    newAlert.currentUser = uid
                    newAlert.fromId = fromId
                    newAlert.post = post
                    newAlert.timestamp = timestamp
                    newAlert.firstName = firstName
                    newAlert.lastName = lastName
                    if let profileImageName = messageThread["image_url"] as? String {
                        newAlert.profileImageName = profileImageName
                    }
                    if self.alertsDictionary[mid] != nil {
                        self.alertsDictionary[mid] = newAlert
                    } else {
                        self.alertsDictionary[mid] = newAlert
                        self.alerts.append(newAlert)
                    }
                    self.attemptReloadOfTable()
                }
            })
        }
    }
    
    fileprivate func attemptReloadOfTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
}














