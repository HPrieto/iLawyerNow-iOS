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
        if FIRAuth.auth()?.currentUser != nil {
            return true
        }
        return false
    }
    
    func observeNotifications() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        print("NewMessage Observing Messages...")
        let newMessageRef = FIRDatabase.database().reference().child("users").child(uid).child("messages")
        newMessageRef.observe(.value, with: {(snapshot) in
            guard var notifications = snapshot.value as? [String:Int] else {
                print("No messages by this user")
                return
            }
            print("User Messages: \(notifications)")
            notifications = self.sortNotifications(notifications)
            // Create new Message Object
            //let alert = Alert(dictionary: dictionary)
            
            // Add new message to messages map
            //self.alerts.append(alert)
            
            // Reload TableView with new messages
            DispatchQueue.main.async(execute: {
                //self.collectionView?.reloadData()
            })
        }, withCancel: nil)
    }
    
    func sortNotifications(_ notifications:[String:Int]) -> [String:Int] {
        return notifications
    }
}
