//
//  PaymentCardViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/6/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension PaymentCardViewController {
    func saveCreditCard() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        guard let user = FIRAuth.auth()?.currentUser else {
            print("User is not signed in...")
            return
        }
        guard let creditCardNumber = self.cardField.text else {
            print("Invalid credit card")
            return
        }
        FIRDatabase.database().reference().child("users").child(user.uid).updateChildValues(["card_number":creditCardNumber]) { (error, ref) in
            if error != nil {
                print("unable to save the credit card number...")
                return
            }
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func setCardNumber() {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        FIRDatabase.database().reference().child("users").child(user.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                if let cardNumber = dictionary["card_number"] as? String {
                    self.cardField.text = cardNumber
                }
            }
        }
    }
}
