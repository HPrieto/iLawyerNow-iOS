//
//  FeedTableViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension FeedTableViewController {
    /* Handle user login status */
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    guard let firstName = dictionary["firstName"] as? String else {
                        return
                    }
                    self.navigationItem.title = "\(firstName)'s feed"
                }
            })
        }
    }
    
    /* Pushes to LoginSignupViewController */
    @objc func handleLogout() {
        self.navigationController?.pushViewController(LoginSignupController(), animated: false)
    }
}
