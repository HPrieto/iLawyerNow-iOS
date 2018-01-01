//
//  LoginSignupController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension LoginSignupController {
    /* Attorney Signup/Login methods */
    func signupAttorney() {
        guard let attorneyEmail = self.attorneyEmailTextField.text, let attorneyPassword = self.attorneyPasswordTextField.text else {
            self.showErrorView(message: "Invalid signup parameters.")
            return
        }
        Auth.auth().createUser(withEmail: attorneyEmail, password: attorneyPassword, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                if let errorMessage = error?.localizedDescription {
                    self.showErrorView(message: errorMessage)
                }
                return
            }
            // Attorney has signed up.
            guard let attorneyFirstName = self.attorneyFirstNameTextField.text, let attorneyLastName = self.attorneyLastNameTextField.text, let attorneyPhoneNumber = self.attorneyPhoneTextField.text, let barNumber = self.attorneyBarTextField.text else {
                self.showErrorView(message: "Invlaid signup parameters.")
                return
            }
            guard let attorney = user?.uid else {
                return
            }
            let attorneyInfo = ["email":attorneyEmail,
                                "phone":attorneyPhoneNumber,
                                "first_name":attorneyFirstName,
                                "last_name":attorneyLastName,
                                "bar_number":barNumber,
                                "is_attorney":true] as [String : Any]
            let ref = Database.database().reference()
            let attorniesRef = ref.child("users").child(attorney)
            attorniesRef.updateChildValues(attorneyInfo, withCompletionBlock: { (err, ref) in
                if err != nil {
                    if let errorMessage = err?.localizedDescription {
                        self.showErrorView(message: errorMessage)
                    }
                    return
                }
                print("New attorney '\(attorneyFirstName)' saved to database successfully.")
            })
            self.popThisView()
        })
    }
    
    /* Member Signup/Login methods */
    func signupMember() {
        guard let memberEmail = self.memberEmailTextField.text, let memberPassword = self.memberPasswordTextField.text else {
            print("Invalid member email and password fields on signup")
            return
        }
        Auth.auth().createUser(withEmail: memberEmail, password: memberPassword, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                if let errorMessage = error?.localizedDescription {
                    self.showErrorView(message: errorMessage)
                }
                return
            }
            // Member has signed up.
            guard let memberFirstName = self.memberFirstNameTextField.text, let memberLastName = self.memberLastNameTextField.text, let memberPhoneNumber = self.memberPhoneTextField.text else {
                self.showErrorView(message: "Invalid fields.")
                print("Invalid member firstname, lastname or phone number")
                return
            }
            guard let member = user?.uid else {
                return
            }
            let memberInfo = ["email":memberEmail,
                              "phone":memberPhoneNumber,
                              "first_name":memberFirstName,
                              "last_name":memberLastName,
                              "is_attorney":false] as [String:Any]
            let ref = Database.database().reference()
            let membersRef = ref.child("users").child(member)
            membersRef.updateChildValues(memberInfo, withCompletionBlock: { (err, ref) in
                if err != nil {
                    if let errorMessage = error?.localizedDescription {
                        self.showErrorView(message: errorMessage)
                    }
                    return
                }
                print("New member '\(memberFirstName)' saved to database successfully.")
            })
            self.popThisView()
        })
    }
    
    func loginUser() {
        guard let email = self.loginEmailTextField.text, let password = self.loginPasswordTextField.text else {
            self.disableLoginButton()
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                if let errorDescription = error?.localizedDescription {
                    self.showErrorView(message: errorDescription)
                }
                print(error.debugDescription)
                return
            }
            print("Member with email '\(email)' has logged in.")
            self.popThisView()
        })
    }
}
