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
        guard let email = self.loginEmailTextField.text,
            let password = self.loginPasswordTextField.text else {
                self.disableLoginButton()
                print("Invalid Login Fields")
                return
        }
        if !self.validEmail(email: email) {
            self.disableLoginButton()
        } else if !self.validPassword(password: password) {
            self.disableLoginButton()
        } else if self.validPassword(password: password) &&
            self.validEmail(email: email) {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
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
    
    @objc func memberSignupButtonClicked() {
        
    }
    
    /* MemberView Actions */
    @objc func memberNavbarLeftButtonClicked() {
        if self.memberSignupNameScrollViewLeftAnchor?.constant == 0 {
            self.animateWelcomeFromMemberView()
        } else {
            self.animateMemberEmailToName()
        }
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
    
    @objc func memberNameToEmailButtonClicked() {
        self.animateMemberNameToEmail()
    }
    
    @objc func attorneySignupButtonClicked() {
        
    }
    
    @objc func loginButtonClicked() {
        self.loginUser()
    }
    
    @objc func errorCancelButtonClicked() {
        self.hideErrorView()
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
        
        self.memberSignupNameScrollViewHeightAnchor?.constant = self.view.bounds.height - keyboardHeight
        self.memberSignupEmailScrollViewHeightAnchor?.constant = self.view.bounds.height - keyboardHeight
        self.memberNameToEmailButtonBottomMargin?.constant = -(keyboardHeight + 25)
        self.memberSignupButtonBottomMargin?.constant = -(keyboardHeight + 25)
        
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
        
        self.memberSignupNameScrollViewHeightAnchor?.constant = self.view.bounds.height
        self.memberSignupEmailScrollViewHeightAnchor?.constant = self.view.bounds.height
        self.memberNameToEmailButtonBottomMargin?.constant = -25
        self.memberSignupButtonBottomMargin?.constant = -25
        
        
        self.loginButtonBottomMargin?.constant = -25
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
