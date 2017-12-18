//
//  LoginSignupController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LoginSignupController {
    @objc func loginFields() {
        
    }
    
    @objc func attorneyFields() {
        
    }
    
    @objc func welcomeNavbarRightButtonClicked() {
        self.animateLoginViewShow()
    }
    
    @objc func loginNavbarLeftButtonClicked() {
        self.animateWelcomeFromLoginView()
    }
    
    @objc func loginNavbarRightButtonClicked() {
        
    }
    
    /* MainDirectory Button Actions */
    @objc func attorneyButtonClicked() {
        self.animateAttorneyViewShow()
    }
    
    @objc func memberButtonClicked() {
        self.animateMemberViewShow()
    }
    
    @objc func memberRightNavButtonClicked() {
        
    }
    
    /* MemberView Actions */
    @objc func memberLeftNavItemClicked() {
        self.view.endEditing(true)
    }
    
    /* Fields for member signup: email, password, phone, first name, last name */
    @objc func memberSignupFields(textField: UITextField) {
 
    }
    
    @objc func memberSignupNameFields(textField: UITextField) {
    }
    
    /* Fields for member signup: email, password, phone, first name, last name */
    @objc func attorneySignupFields(textField: UITextField) {
        // Check for valid signup member email, phone and password
    }
    
    @objc func attorneySignupNameFields(textField: UITextField) {
    }
    
    @objc func attorneyNavbarLeftButtonClicked() {
        if self.attorneySignupNameScrollViewLeftAnchor?.constant == 0 {
            self.animateWelcomeFromAttorneyView()
        } else {
            self.animateAttorneyEmailToName()
        }
    }
    
    @objc func attorneyRightNavButtonClicked() {
    }
    
    @objc func attorneyNameToEmailButtonClicked() {
        self.animateAttorneyNameToEmail()
    }
    
    @objc func attorneySignupButtonClicked() {
        
    }
    
    @objc func loginButtonClicked() {
        
    }
    
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let keyboardHeight = keyboardFrame!.height
        self.loginScrollViewHeightAnchor?.constant = self.view.bounds.height - keyboardHeight
        self.attorneySignupNameScrollViewHeightAnchor?.constant = self.view.bounds.height - keyboardHeight
        self.attorneySignupEmailScrollViewHeightAnchor?.constant = self.view.bounds.height - keyboardHeight
        self.attorneyNameToEmailButtonBottomMargin?.constant = -(keyboardHeight + 25)
        self.attorneySignupButtonBottomMargin?.constant = -(keyboardHeight + 25)
        self.loginButtonBottomMargin?.constant = -(keyboardHeight + 25)
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        self.loginScrollViewHeightAnchor?.constant = self.view.bounds.height
        self.attorneySignupNameScrollViewHeightAnchor?.constant = self.view.bounds.height
        self.attorneySignupEmailScrollViewHeightAnchor?.constant = self.view.bounds.height
        self.attorneyNameToEmailButtonBottomMargin?.constant = -25
        self.attorneySignupButtonBottomMargin?.constant = -25
        self.loginButtonBottomMargin?.constant = -25
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
