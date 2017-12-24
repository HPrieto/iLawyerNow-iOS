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
    
    @objc func attorneyNameFields() {
        guard let firstName   = self.attorneyFirstNameTextField.text,
              let lastName    = self.attorneyLastNameTextField.text,
              let phoneNumber = self.attorneyPhoneTextField.text else {
            return
        }
        if !self.validName(name: firstName) {
            self.disableAttorneyNameToEmailButton()
        } else if !self.validName(name: lastName) {
            self.disableAttorneyNameToEmailButton()
        } else if !self.validPhoneNumber(phoneNumber: phoneNumber) {
            self.disableAttorneyNameToEmailButton()
        } else {
            self.enableAttorneyNameToEmailButton()
        }
    }
    
    @objc func attorneyFields() {
        guard let firstName   = self.attorneyFirstNameTextField.text,
              let lastName    = self.attorneyLastNameTextField.text,
              let phoneNumber = self.attorneyPhoneTextField.text,
              let barNumber   = self.attorneyBarTextField.text,
              let email       = self.attorneyEmailTextField.text,
              let password    = self.attorneyPasswordTextField.text else {
            return
        }
        if !self.validName(name: firstName) {
            self.disableAttorneySignupButton()
        } else if !self.validName(name: lastName) {
            self.disableAttorneySignupButton()
        } else if !self.validPhoneNumber(phoneNumber: phoneNumber) {
            self.disableAttorneySignupButton()
        } else if !self.validateBar(bar: barNumber) {
            self.disableAttorneySignupButton()
        } else if !self.validEmail(email: email) {
            self.disableAttorneySignupButton()
        } else if !self.validPassword(password: password) {
            self.disableAttorneySignupButton()
        } else {
            self.enableAttorneySignupButton()
        }
    }
    
    @objc func memberNameFields() {
        guard let firstName   = self.memberFirstNameTextField.text,
              let lastName    = self.memberLastNameTextField.text,
              let phoneNumber = self.memberPhoneTextField.text else {
                return
        }
        if !self.validName(name: firstName) {
            self.disableMemberNameToEmailButton()
        } else if !self.validName(name: lastName) {
            self.disableMemberNameToEmailButton()
        } else if !self.validPhoneNumber(phoneNumber: phoneNumber) {
            self.disableMemberNameToEmailButton()
        } else {
            self.enableMemberNameToEmailButton()
        }
    }
    
    @objc func memberFields() {
        guard let firstName   = self.memberFirstNameTextField.text,
              let lastName    = self.memberLastNameTextField.text,
              let phoneNumber = self.memberPhoneTextField.text,
              let email       = self.memberEmailTextField.text,
              let password    = self.memberPasswordTextField.text else {
                return
        }
        if !self.validName(name: firstName) {
            self.disableMemberSignupButton()
        } else if !self.validName(name: lastName) {
            self.disableMemberSignupButton()
        } else if !self.validPhoneNumber(phoneNumber: phoneNumber) {
            self.disableMemberSignupButton()
        }  else if !self.validEmail(email: email) {
            self.disableMemberSignupButton()
        } else if !self.validPassword(password: password) {
            self.disableMemberSignupButton()
        } else {
            self.enableMemberSignupButton()
        }
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
        self.signupMember()
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
        self.signupAttorney()
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
