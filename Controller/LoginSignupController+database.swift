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
        /*guard let attorneyEmail = self.attorneySignupEmailTextField.text, let attorneyPassword = self.attorneySignupPasswordTextField.text else {
            print("Invalid attorney email and password fields on signup")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: attorneyEmail, password: attorneyPassword, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            // Attorney has signed up.
            guard let attorneyFirstName = self.attorneySignupFirstNameTextField.text, let attorneyLastName = self.attorneySignupLastNameTextField.text, let attorneyPhoneNumber = self.attorneySignupPhoneTextField.text, let barNumber = self.attorneySignupBarNumberTextField.text else {
                self.popThisView()
                print("Invalid attorney firstname, lastname or phone number")
                return
            }
            guard let attorney = user?.uid else {
                self.popThisView()
                return
            }
            let attorneyInfo = ["email":attorneyEmail,
                                "phone":attorneyPhoneNumber,
                                "firstName":attorneyFirstName,
                                "lastName":attorneyLastName,
                                "barNumber":barNumber,
                                "isAttorney":true] as [String : Any]
            let ref = FIRDatabase.database().reference()
            let attorniesRef = ref.child("users").child(attorney)
            attorniesRef.updateChildValues(attorneyInfo, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err.debugDescription)
                    self.popThisView()
                    return
                }
                print("New attorney '\(attorneyFirstName)' saved to database successfully.")
            })
            self.popThisView()
        })*/
    }
    
    /* Member Signup/Login methods */
    func signupMember() {
        /*guard let memberEmail = self.memberSignupEmailTextField.text, let memberPassword = self.memberSignupPasswordTextField.text else {
            print("Invalid member email and password fields on signup")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: memberEmail, password: memberPassword, completion: { (user, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            // Member has signed up.
            guard let memberFirstName = self.memberSignupFirstNameTextField.text, let memberLastName = self.memberSignupLastNameTextField.text, let memberPhoneNumber = self.memberSignupPhoneTextField.text else {
                self.popThisView()
                print("Invalid member firstname, lastname or phone number")
                return
            }
            guard let member = user?.uid else {
                self.popThisView()
                return
            }
            let memberInfo = ["email":memberEmail,
                              "phone":memberPhoneNumber,
                              "firstName":memberFirstName,
                              "lastName":memberLastName,
                              "isAttorney":false] as [String:Any]
            let ref = FIRDatabase.database().reference()
            let membersRef = ref.child("users").child(member)
            membersRef.updateChildValues(memberInfo, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err.debugDescription)
                    self.popThisView()
                    return
                }
                print("New member '\(memberFirstName)' saved to database successfully.")
            })
            self.popThisView()
        })*/
    }
    
    func loginUser() {
        guard let email = self.loginEmailTextField.text, let password = self.loginPasswordTextField.text else {
            self.disableLoginButton()
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
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
