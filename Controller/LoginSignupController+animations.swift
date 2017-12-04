//
//  LoginSignupController+animations.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LoginSignupController {
    /* Animates the alpha changes in memberview */
    func animateMemberViewShow() {
        self.memberViewButton.setTitle("Signup", for: .normal)
        self.memberNavbarItems.rightBarButtonItem?.title = "Done"
        self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
        self.memberLoginView.alpha = 1
        self.memberSignupViewLeftAnchor?.isActive = true
        self.memberSignupViewRightAnchor?.isActive = false
        self.animateMemberViewAlpha(alpha: self.DISAPPEAR, animationDuration: self.INSTANT)
        self.animateMemberViewAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
    }
    
    func animateMemberViewHide() {
        self.animateMemberViewAlpha(alpha: self.DISAPPEAR, animationDuration: self.RAPID)
    }
    
    func animateMemberViewAlpha(alpha:CGFloat,animationDuration:Double) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.memberView.alpha = alpha
        }) { (true) in
            if alpha == self.APPEAR {
                self.memberLoginEmailTextField.becomeFirstResponder()
            }
        }
    }
    
    /* Animates margin changes in memberview */
    func memberLoginToSignupView() {
        self.view.endEditing(true)
        self.memberViewButton.setTitle("Login", for: .normal)
        self.memberNavbarItems.rightBarButtonItem?.title = "Next"
        self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
        self.memberNavbarItems.title = "Create an Account"
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.memberLoginView.alpha = self.DISAPPEAR
            self.memberSignupViewLeftAnchor?.isActive = false
            self.memberSignupViewRightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (true) in
            self.memberSignupEmailTextField.becomeFirstResponder()
        }
    }
    
    func memberSignupToLoginView() {
        self.view.endEditing(true)
        self.memberViewButton.setTitle("Signup", for: .normal)
        self.memberNavbarItems.rightBarButtonItem?.title = "Done"
        self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
        self.memberNavbarItems.title = "Login"
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.memberLoginView.alpha = self.APPEAR
            self.memberSignupViewLeftAnchor?.isActive = true
            self.memberSignupViewRightAnchor?.isActive = false
            self.view.layoutIfNeeded()
        }) { (true) in
            self.memberLoginEmailTextField.becomeFirstResponder()
        }
    }
    
    func memberSignupEmailToName() {
        self.view.endEditing(true)
        self.memberNavbarItems.rightBarButtonItem?.title = "Done"
        self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
        self.memberViewButton.setTitle("Back", for: .normal)
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.memberSignupView.alpha = self.DISAPPEAR
            self.memberSignupNameViewLeftAnchor?.isActive = false
            self.memberSignupNameViewRightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (true) in
            self.memberSignupFirstNameTextField.becomeFirstResponder()
        }
    }
    
    func memberSignupNameToEmail() {
        self.view.endEditing(true)
        self.memberNavbarItems.rightBarButtonItem?.title = "Next"
        self.memberViewButton.setTitle("Login", for: .normal)
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.memberSignupView.alpha = self.APPEAR
            self.memberSignupNameViewLeftAnchor?.isActive = true
            self.memberSignupNameViewRightAnchor?.isActive = false
            self.view.layoutIfNeeded()
        }) { (true) in
            self.memberSignupEmailTextField.becomeFirstResponder()
        }
    }
    
    /* Animates the alpha changes in attorneyview */
    func animateAttorneyViewShow() {
        self.attorneyViewButton.setTitle("Signup", for: .normal)
        self.attorneyNavbarItems.title = "Login"
        self.attorneyNavbarItems.rightBarButtonItem?.title = "Done"
        self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
        self.attorneyLoginView.alpha = 1
        self.attorneySignupViewLeftAnchor?.isActive = false
        self.attorneySignupViewRightAnchor?.isActive = true
        self.attorneySignupNameViewRightAnchor?.isActive = true
        self.attorneySignupNameViewLeftAnchor?.isActive = false
        self.animateAttorneyViewAlpha(alpha: self.DISAPPEAR, animationDuration: self.INSTANT)
        self.animateAttorneyViewAlpha(alpha: self.APPEAR, animationDuration: self.RAPID)
    }
    
    func animateAttorneyViewHide() {
        self.animateAttorneyViewAlpha(alpha: self.DISAPPEAR, animationDuration: self.RAPID)
    }
    
    func animateAttorneyViewAlpha(alpha:CGFloat,animationDuration:Double) {
        UIView.animate(withDuration: animationDuration, animations: {
            self.attorneyView.alpha = alpha
        }) { (true) in
            if alpha == self.APPEAR {
                self.attorneyLoginEmailTextField.becomeFirstResponder()
            }
        }
    }
    
    /* Animates margin changes in memberview */
    func attorneyLoginToSignupView() {
        self.view.endEditing(true)
        self.attorneyViewButton.setTitle("Login", for: .normal)
        self.attorneyNavbarItems.title = "Create an Account"
        self.attorneyNavbarItems.rightBarButtonItem?.title = "Next"
        self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.attorneyLoginView.alpha = self.DISAPPEAR
            self.attorneySignupViewLeftAnchor?.isActive = true
            self.attorneySignupViewRightAnchor?.isActive = false
            self.view.layoutIfNeeded()
        }) { (true) in
            self.attorneySignupEmailTextField.becomeFirstResponder()
        }
    }
    
    func attorneySignupToLoginView() {
        self.view.endEditing(true)
        self.attorneyViewButton.setTitle("Signup", for: .normal)
        self.attorneyNavbarItems.title = "Login"
        self.attorneyNavbarItems.rightBarButtonItem?.title = "Done"
        self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.attorneyLoginView.alpha = self.APPEAR
            self.attorneySignupViewLeftAnchor?.isActive = false
            self.attorneySignupViewRightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (true) in
            self.attorneyLoginEmailTextField.becomeFirstResponder()
        }
    }
    
    func attorneySignupEmailToName() {
        self.view.endEditing(true)
        self.attorneyViewButton.setTitle("Back", for: .normal)
        self.attorneyNavbarItems.rightBarButtonItem?.title = "Done"
        self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.attorneySignupView.alpha = self.DISAPPEAR
            self.attorneySignupNameViewLeftAnchor?.isActive = true
            self.attorneySignupNameViewRightAnchor?.isActive = false
            self.view.layoutIfNeeded()
        }) { (true) in
            self.attorneySignupFirstNameTextField.becomeFirstResponder()
        }
    }
    
    func attorneySignupNameToEmail() {
        self.view.endEditing(true)
        self.attorneyViewButton.setTitle("Login", for: .normal)
        self.attorneyNavbarItems.rightBarButtonItem?.title = "Next"
        self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
        UIView.animate(withDuration: self.GRADUAL, animations: {
            self.attorneySignupView.alpha = self.APPEAR
            self.attorneySignupNameViewLeftAnchor?.isActive = false
            self.attorneySignupNameViewRightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (true) in
            self.attorneySignupEmailTextField.becomeFirstResponder()
        }
    }
}
