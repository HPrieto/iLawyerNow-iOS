//
//  PhoneViewController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension PhoneViewController {
    /* UIComponent Listeners */
    @objc func phoneNumberChanging(_ textField: UITextField) {
        if let count = textField.text?.count {
            if (count > 6 && count < 11) {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    /* Right Bar Button Item Action: Save Phone Number to database */
    @objc func savePhoneNumber() {
        self.saveNumber()
    }
}
