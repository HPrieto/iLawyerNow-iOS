//
//  PhoneViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension PhoneViewController {
    /* Loads user's phone number */
    func setPhoneNumber() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        Database.database().reference().child("users").child(user.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                if let phoneNumber = dictionary["phone"] as? String {
                    self.phoneField.text = phoneNumber
                }
            }
        }
    }
    
    /* Saves user's phone number to database */
    func saveNumber() {
        guard let user = Auth.auth().currentUser,
              let phone = self.phoneField.text else {
            return
        }
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phone))
            && phone.underestimatedCount > 15 && phone.underestimatedCount < 7 {
            return
        }
        Database.database().reference().child("users").child(user.uid).updateChildValues(["phone":phone])
        self.navigationController?.popViewController(animated: true)
    }
}
