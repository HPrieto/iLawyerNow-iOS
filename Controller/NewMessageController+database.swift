//
//  NewMessageController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/4/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension NewMessageController {
    /* Fetchs user's info and sets it to fields */
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                let user = User()
                user.firstName = dictionary["firstName"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                
            }
        }
    }
}
