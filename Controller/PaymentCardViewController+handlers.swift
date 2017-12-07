//
//  PaymentCardViewController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/6/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension PaymentCardViewController {
    /* Right Bar Button Item Action: Go Back once changes are done */
    @objc func saveCardNumber() {
        self.saveCreditCard()
    }
    
    /* Left Bar Button Item Action: Go Back */
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /* UIComponent Listeners */
    @objc func cardNumberChanging(_ textField: UITextField) {
        if let cardNumber = self.cardField.text {
            if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cardNumber))
                && cardNumber.underestimatedCount == 16 {
               self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
}
