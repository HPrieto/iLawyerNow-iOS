//
//  LoginSignupController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension LoginSignupController {
    /* MainDirectory Button Actions */
    @objc func attorneyLogin() {
        self.animateAttorneyViewShow()
    }
    @objc func memberLogin() {
        self.animateMemberViewShow()
    }
    
    /* MemberView Actions */
    @objc func memberLeftNavItemClicked() {
        self.animateMemberViewHide()
        self.view.endEditing(true)
    }
    @objc func memberRightNavButtonClicked() {
        print("member right navbutton clicked...")
        if self.memberNavbarItems.rightBarButtonItem?.title == "Done" {
            if self.memberViewButton.titleLabel?.text == "Login" {
                print("Member signed up...")
            } else if self.memberViewButton.titleLabel?.text == "Signup" {
                print("Member logged in...")
                self.loginMember()
            } else if self.memberViewButton.titleLabel?.text == "Back" {
                self.signupMember()
            }
        } else if self.memberNavbarItems.rightBarButtonItem?.title == "Next" {
            print("Email to name...")
            self.memberSignupEmailToName()
        }
    }
    @objc func memberViewButtonClicked() {
        if self.memberViewButton.titleLabel?.text == "Signup" {
            self.memberLoginToSignupView()
        } else if self.memberViewButton.titleLabel?.text == "Login" {
            self.memberSignupToLoginView()
        } else if self.memberViewButton.titleLabel?.text == "Back" {
            self.memberSignupNameToEmail()
        }
    }
    /* Fields for member signup: email, password, phone, first name, last name */
    @objc func memberSignupFields(textField: UITextField) {
        // Check for valid signup member email, phone and password
        if let email = self.memberSignupEmailTextField.text,
            let phone = self.memberSignupPhoneTextField.text,
            let password = self.memberSignupPasswordTextField.text {
            if !self.validEmail(email: email) {
                print("Invalid email")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validPhoneNumber(phoneNumber: phone) {
                print("Invalid phone")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validPassword(password: password) {
                print("Invalid password")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            } else {
                print("All email fields are valid!")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    @objc func memberSignupNameFields(textField: UITextField) {
        // Check for valid member firstname, lastname
        if let firstName = self.memberSignupFirstNameTextField.text,
            let lastName = self.memberSignupLastNameTextField.text {
            if !self.validName(name: firstName) {
                print("Invalid First Name")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validName(name: lastName) {
                print("Invalid Last Name")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            } else {
                print("All name fields are valid!")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    @objc func memberLoginFields(textField: UITextField) {
        // Check for valid login member email, and password
        if let email = self.memberLoginEmailTextField.text,
            let password = self.memberLoginPasswordTextField.text {
            if !self.validEmail(email: email) {
                print("Invalid email")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            }  else if !self.validPassword(password: password) {
                print("Invalid password")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = false
            } else {
                print("All email fields are valid!")
                self.memberNavbarItems.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    /* Fields for member signup: email, password, phone, first name, last name */
    @objc func attorneySignupFields(textField: UITextField) {
        // Check for valid signup member email, phone and password
        if let email = self.attorneySignupEmailTextField.text,
            let phone = self.attorneySignupPhoneTextField.text,
            let password = self.attorneySignupPasswordTextField.text {
            if !self.validEmail(email: email) {
                print("Invalid email")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validPhoneNumber(phoneNumber: phone) {
                print("Invalid phone")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validPassword(password: password) {
                print("Invalid password")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else {
                print("All email fields are valid!")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    @objc func attorneySignupNameFields(textField: UITextField) {
        // Check for valid member firstname, lastname
        if let firstName = self.attorneySignupFirstNameTextField.text,
            let lastName  = self.attorneySignupLastNameTextField.text,
            let barNumber = self.attorneySignupBarNumberTextField.text {
            if !self.validName(name: firstName) {
                print("Invalid First Name")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validName(name: lastName) {
                print("Invalid Last Name")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else if !self.validateBar(bar: barNumber) {
                print("Invalid Bar Number")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else {
                print("All name fields are valid!")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    @objc func attorneyLoginFields(textField: UITextField) {
        // Check for valid login member email, and password
        if let email = self.attorneyLoginEmailTextField.text,
            let password = self.attorneyLoginPasswordTextField.text {
            if !self.validEmail(email: email) {
                print("Invalid email")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            }  else if !self.validPassword(password: password) {
                print("Invalid password")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
            } else {
                print("All email fields are valid!")
                self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = true
            }
        }
    }
    
    /* AttorneyView Actions */
    @objc func attorneyViewButtonClicked() {
        if self.attorneyViewButton.titleLabel?.text == "Signup" {
            self.attorneyLoginToSignupView()
        } else if self.attorneyViewButton.titleLabel?.text == "Login" {
            self.attorneySignupToLoginView()
        } else if self.attorneyViewButton.titleLabel?.text == "Back" {
            self.attorneySignupNameToEmail()
        }
    }
    @objc func attorneyLeftNavItemClicked() {
        print("attorney left navitem clicked")
        self.animateAttorneyViewHide()
        self.view.endEditing(true)
    }
    @objc func attorneyRightNavButtonClicked() {
        if self.attorneyNavbarItems.rightBarButtonItem?.title == "Next" {
            self.attorneySignupEmailToName()
            self.attorneyNavbarItems.rightBarButtonItem?.isEnabled = false
        } else if attorneyNavbarItems.rightBarButtonItem?.title == "Done" {
            if self.attorneyViewButton.titleLabel?.text == "Back" {
                print("Signed up...")
                self.signupAttorney()
            } else if self.attorneyViewButton.titleLabel?.text == "Signup" {
                print("Logged in...")
                self.loginAttorney()
            }
        }
    }
}
