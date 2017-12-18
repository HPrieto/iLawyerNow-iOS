//
//  LoginSignupController+animations.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LoginSignupController {
    func animateLoginViewShow() {
        UIView.animate(withDuration: self.RAPID, animations: {
            self.welcomeView.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateLoginViewAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
        }
    }
    
    func animateWelcomeFromLoginView() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.RAPID, animations: {
            self.loginView.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateWelcomeViewAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
        }
    }
    
    func animateWelcomeFromAttorneyView() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.RAPID, animations: {
            self.attorneyView.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateWelcomeViewAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
        }
    }
    
    func animateAttorneyNameToEmail() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.RAPID, animations: {
            self.attorneySignupNameScrollViewLeftAnchor?.constant = -self.view.bounds.width
            self.attorneyNameToEmailButton.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateAttorneyEmailView(animationDuration: self.RAPID, leftMargin: 0, signupButtonAlpha: 1.0)
        }
    }
    
    func animateAttorneyEmailToName() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.RAPID, animations: {
            self.attorneySignupEmailScrollViewLeftAnchor?.constant = self.view.bounds.width
            self.attorneySignupButton.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateAttorneyNameView(animationDuration: self.RAPID, leftMargin: 0, signupButtonAlpha: 1.0)
        }
    }
    
    func animateAttorneyEmailView(animationDuration: TimeInterval, leftMargin: CGFloat, signupButtonAlpha: CGFloat) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.attorneySignupEmailScrollViewLeftAnchor?.constant = leftMargin
            self.attorneySignupButton.alpha = signupButtonAlpha
            self.view.layoutIfNeeded()
        }) { (true) in
            if self.attorneySignupEmailScrollViewLeftAnchor?.constant == 0 {
                self.attorneyBarTextField.becomeFirstResponder()
            } else {
                self.view.endEditing(true)
            }
        }
    }
    
    func animateAttorneyNameView(animationDuration: TimeInterval, leftMargin: CGFloat, signupButtonAlpha: CGFloat) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.attorneySignupNameScrollViewLeftAnchor?.constant = leftMargin
            self.attorneyNameToEmailButton.alpha = signupButtonAlpha
            self.view.layoutIfNeeded()
        }) { (true) in
            if self.attorneySignupNameScrollViewLeftAnchor?.constant == 0 {
                self.attorneyFirstNameTextField.becomeFirstResponder()
            } else {
                self.view.endEditing(true)
            }
        }
    }
    
    func animateMemberViewShow() {
        UIView.animate(withDuration: self.RAPID, animations: {
            self.welcomeView.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateMemberViewSignupAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
        }
    }
    
    func animateMemberViewHide() {
        self.animateMemberViewSignupAlpha(alpha: self.DISAPPEAR, animationDuration: self.RAPID)
    }
    
    func animateLoginViewAlpha(alpha:CGFloat,animationDuration:Double) {
        self.loginEmailTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        self.loginPasswordTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        UIView.animate(withDuration: animationDuration, animations: {
            self.loginView.alpha = alpha
        }) { (true) in
            if alpha == self.APPEAR {
                self.loginEmailTextField.becomeFirstResponder()
            } else {
                self.view.endEditing(true)
            }
        }
    }
    
    func animateWelcomeViewAlpha(alpha:CGFloat,animationDuration:Double) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.welcomeView.alpha = alpha
        }) { (true) in
            // do something on comepletion
        }
    }
    
    func animateMemberViewSignupAlpha(alpha:CGFloat,animationDuration:Double) {
        UIView.animate(withDuration: animationDuration, animations: {
        }) { (true) in
            if alpha == self.APPEAR {
            } else {
                self.view.endEditing(true)
            }
        }
    }
    
    /* Animates margin changes in memberview */
    func memberLoginToSignupView() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
        }
    }
    
    func memberSignupToLoginView() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
            self.loginEmailTextField.becomeFirstResponder()
        }
    }
    
    /* Animates the alpha changes in attorneyview */
    func animateAttorneyViewShow() {
        self.attorneySignupNameScrollViewLeftAnchor?.constant = self.view.bounds.width
        self.attorneySignupEmailScrollViewLeftAnchor?.constant = self.view.bounds.width
        self.attorneyNameToEmailButton.alpha = 1
        self.attorneySignupButton.alpha = 0
        self.attorneyFirstNameTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        self.attorneyLastNameTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        self.attorneyPhoneTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        self.attorneyEmailTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        self.attorneyPasswordTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        self.attorneyBarTextField.setBottomLine(borderColor: UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.5))
        UIView.animate(withDuration: self.RAPID, animations: {
            self.welcomeView.alpha = self.DISAPPEAR
            self.view.layoutIfNeeded()
        }) { (true) in
            self.animateAttorneyViewAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
            UIView.animate(withDuration: self.GRADUAL, animations: {
                self.attorneySignupNameScrollViewLeftAnchor?.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func animateAttorneyViewHide() {
    }
    
    func animateAttorneyViewAlpha(alpha:CGFloat,animationDuration:Double) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.attorneyView.alpha = alpha
            self.view.layoutIfNeeded()
        }) { (true) in
            if alpha == self.APPEAR {
                self.attorneyFirstNameTextField.becomeFirstResponder()
            } else {
                self.view.endEditing(true)
            }
        }
    }
    
    func attorneySignupEmailToName() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
        }
    }
    
    func attorneySignupNameToEmail() {
        self.view.endEditing(true)
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
        }
    }
}
