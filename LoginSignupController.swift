//
//  LoginSignupController.swift
//  iLawyer
//
//  Created by Heriberto Prieto on 11/25/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

class LoginSignupController: UIViewController {
    /* Global Constants */
    let TEAL = UIColor(r: 19, g: 136, b: 143)
    let DISAPPEAR:CGFloat = 0.0
    let APPEAR:CGFloat = 1.0
    let INSTANT:Double = 0.0
    let RAPID:Double = 0.25
    let GRADUAL:Double = 0.5
    let SLOWLY:Double = 0.75
    let VERYSLOW:Double = 1.0
    let INVIEW:CGFloat = 0.0
    var OFFVIEW = CGFloat() // not a constant but whatevs
    /* DirectoryView Components */
    let ilawyerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ilawyer_home_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let memberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Member", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 25)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let attorneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Attorney", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 25)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /* MemberView Components */
    let memberView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    let memberNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.tintColor = UIColor(r: 19, g: 136, b: 143)
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    let memberNavbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.title = "Login"
        navItems.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(memberLeftNavItemClicked))
        navItems.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(memberRightNavButtonClicked))
        navItems.rightBarButtonItem?.isEnabled = false
        return navItems
    }()
    let memberViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signup", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(memberViewButtonClicked), for: .touchUpInside)
        return button
    }()
    let memberLoginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let memberLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "Member"
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let memberLoginEmailTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.placeholder = "Email Address"
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.addTarget(self, action: #selector(memberLoginFields), for: .editingChanged)
        return textField
    }()
    let memberLoginPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        textField.addTarget(self, action: #selector(memberLoginFields), for: .editingChanged)
        return textField
    }()
    let memberSignupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let memberSignupLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your email?"
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let memberSignupEmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.addTarget(self, action: #selector(memberSignupFields), for: .editingChanged)
        return textField
    }()
    let memberSignupPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.phonePad
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        textField.addTarget(self, action: #selector(memberSignupFields), for: .editingChanged)
        return textField
    }()
    let memberSignupPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(memberSignupFields), for: .editingChanged)
        return textField
    }()
    let memberSignupNameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let memberSignupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your name?"
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let memberSignupFirstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(memberSignupNameFields), for: .editingChanged)
        return textField
    }()
    let memberSignupLastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(memberSignupNameFields), for: .editingChanged)
        return textField
    }()
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
                self.popThisView()
            } else if self.memberViewButton.titleLabel?.text == "Back" {
                self.popThisView()
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
    /* Member Field Validation methods */
    func validEmail(email: String) -> Bool {
        return self.regexValidation(string: email, regEx: "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}")
    }
    func validPassword(password: String) -> Bool {
        return self.regexValidation(string: password, regEx: "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()-_=+{}|?>.<,:;~`’]{6,}$")
    }
    func validPhoneNumber(phoneNumber: String) -> Bool {
        return self.regexValidation(string: phoneNumber, regEx: "(?:(\\+\\d\\d\\s+)?((?:\\(\\d\\d\\)|\\d\\d)\\s+)?)(\\d{4,5}\\-?\\d{4})")
    }
    func validName(name: String) -> Bool {
        return self.regexValidation(string: name, regEx: "^[0-9a-zA-Z\\_]{2,18}$")
    }
    func validateBar(bar: String) -> Bool {
        return self.regexValidation(string: bar, regEx: "(?:(\\+\\d\\d\\s+)?((?:\\(\\d\\d\\)|\\d\\d)\\s+)?)(\\d{4,5}\\-?\\d{4})")
    }
    func regexValidation(string: String, regEx: String) -> Bool {
        var returnValue = true
        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    /* Member Signup/Login methods */
    func signupMember() {
        guard let memberEmail = self.memberSignupEmailTextField.text, let memberPassword = self.memberSignupPasswordTextField.text else {
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
                print("Invalid member firstname, lastname or phone number")
                return
            }
            let newMember = ["email":memberEmail,
                             "phone":memberPhoneNumber,
                             "firstName":memberFirstName,
                             "lastName":memberLastName]
        })
    }
    func loginMember() {
        guard let memberEmail = self.memberLoginEmailTextField.text, let memberPassword = self.memberLoginPasswordTextField.text else {
            print("Invalid member login email or password is invalid.")
            return
        }
        FIRAuth.auth()?.signIn(withEmail: memberEmail, password: memberPassword, completion: { (user, error) in
            
        })
    }
    /* AttorneyView Components */
    let attorneyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    let attorneyNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.tintColor = UIColor(r: 19, g: 136, b: 143)
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    let attorneyNavbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.title = "Login"
        navItems.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(attorneyLeftNavItemClicked))
        navItems.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(attorneyRightNavButtonClicked))
        navItems.rightBarButtonItem?.isEnabled = false
        return navItems
    }()
    let attorneyViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signup", for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 0
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.clearsContextBeforeDrawing = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(attorneyViewButtonClicked), for: .touchUpInside)
        return button
    }()
    let attorneyLoginView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attorneyLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "Attorney"
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let attorneyLoginEmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyLoginFields), for: .editingChanged)
        return textField
    }()
    let attorneyLoginPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyLoginFields), for: .editingChanged)
        return textField
    }()
    let attorneySignupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attorneySignupLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your email?"
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let attorneySignupEmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneySignupFields), for: .editingChanged)
        return textField
    }()
    let attorneySignupPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.phonePad
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneySignupFields), for: .editingChanged)
        return textField
    }()
    let attorneySignupPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneySignupFields), for: .editingChanged)
        return textField
    }()
    let attorneySignupNameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let attorneySignupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your name?"
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let attorneySignupFirstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneySignupNameFields), for: .editingChanged)
        return textField
    }()
    let attorneySignupLastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.leftViewMode = UITextFieldViewMode.always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneySignupNameFields), for: .editingChanged)
        return textField
    }()
    let attorneySignupBarNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Bar Number"
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.white
        textField.keyboardType = UIKeyboardType.phonePad
        textField.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneySignupNameFields), for: .editingChanged)
        return textField
    }()
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
                self.popThisView()
            } else if self.attorneyViewButton.titleLabel?.text == "Signup" {
                print("Logged in...")
                self.popThisView()
            }
        }
    }
    func popThisView() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: false)
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
    /* Controller Lifecycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = self.TEAL
        self.OFFVIEW = self.view.bounds.width
        self.memberNavbar.setItems([self.memberNavbarItems], animated: true)
        self.attorneyNavbar.setItems([self.attorneyNavbarItems], animated: true)
        self.initializeView()
        self.initializeMemberView()
        self.initializeAttorneyView()
    }
    /* Initialize View */
    func initializeView() {
        // Add buttons to view
        self.view.addSubview(self.ilawyerImage)
        self.view.addSubview(self.attorneyButton)
        self.view.addSubview(self.memberButton)
        // Add button actions
        self.attorneyButton.addTarget(self, action: #selector(attorneyLogin), for: .touchUpInside)
        self.memberButton.addTarget(self, action: #selector(memberLogin), for: .touchUpInside)
        // ilawyer imageview constraints
        self.ilawyerImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.ilawyerImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        self.ilawyerImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.ilawyerImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // attorney button constraints left
        self.attorneyButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.attorneyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.attorneyButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.attorneyButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width/2).isActive = true
        // member button constraints right
        self.memberButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.memberButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.memberButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.memberButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width/2).isActive = true
    }
    /* Button Actions */
    @objc func attorneyLogin() {
        self.animateAttorneyViewShow()
    }
    @objc func memberLogin() {
        self.animateMemberViewShow()
    }
    /* MemberView Constraint Variables */
    var memberSignupViewLeftAnchor: NSLayoutConstraint?
    var memberSignupViewRightAnchor: NSLayoutConstraint?
    var memberSignupNameViewLeftAnchor: NSLayoutConstraint?
    var memberSignupNameViewRightAnchor: NSLayoutConstraint?
    /* Initialize MemberViewComponents */
    func initializeMemberView() {
        // Add SubViews to View
        self.view.addSubview(self.memberView)
        
        // Add SubViews to memberview
        self.memberView.addSubview(self.memberNavbar)
        self.memberView.addSubview(self.memberViewButton)
        self.memberView.addSubview(self.memberLoginView)
        self.memberView.addSubview(self.memberSignupView)
        self.memberView.addSubview(self.memberSignupNameView)
        
        // Add Subviews to memberloginview
        self.memberLoginView.addSubview(self.memberLoginLabel)
        self.memberLoginView.addSubview(self.memberLoginPasswordTextField)
        self.memberLoginView.addSubview(self.memberLoginEmailTextField)
        
        // Add Subviews to membersignupview
        self.memberSignupView.addSubview(self.memberSignupLabel)
        self.memberSignupView.addSubview(self.memberSignupEmailTextField)
        self.memberSignupView.addSubview(self.memberSignupPhoneTextField)
        self.memberSignupView.addSubview(self.memberSignupPasswordTextField)
        
        // Add Subviews to membersignupnameview
        self.memberSignupNameView.addSubview(self.memberSignupNameLabel)
        self.memberSignupNameView.addSubview(self.memberSignupFirstNameTextField)
        self.memberSignupNameView.addSubview(self.memberSignupLastNameTextField)
        
        // Constraints
        self.memberView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.memberView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.memberView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.memberView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // navbar constraints
        self.memberNavbar.leftAnchor.constraint(equalTo: self.memberView.leftAnchor).isActive = true
        self.memberNavbar.rightAnchor.constraint(equalTo: self.memberView.rightAnchor).isActive = true
        self.memberNavbar.topAnchor.constraint(equalTo: self.memberView.topAnchor).isActive = true
        
        // MemberView bottom button
        self.memberViewButton.bottomAnchor.constraint(equalTo: self.memberView.bottomAnchor, constant: -50).isActive = true
        self.memberViewButton.centerXAnchor.constraint(equalTo: self.memberView.centerXAnchor).isActive = true
        self.memberViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberViewButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        // MemberViewLogin Constraints
        self.memberLoginView.topAnchor.constraint(equalTo: self.memberNavbar.bottomAnchor).isActive = true
        self.memberLoginView.bottomAnchor.constraint(equalTo: self.memberViewButton.topAnchor).isActive = true
        self.memberLoginView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        self.memberLoginView.rightAnchor.constraint(equalTo: self.memberView.rightAnchor).isActive = true
        
        // MemberViewLogin Component Constraints
        self.memberLoginLabel.topAnchor.constraint(equalTo: self.memberLoginView.topAnchor, constant: 50).isActive = true
        self.memberLoginLabel.centerXAnchor.constraint(equalTo: self.memberLoginView.centerXAnchor).isActive = true
        
        self.memberLoginEmailTextField.topAnchor.constraint(equalTo: self.memberLoginLabel.bottomAnchor, constant: 50).isActive = true
        self.memberLoginEmailTextField.leftAnchor.constraint(equalTo: self.memberLoginView.leftAnchor).isActive = true
        self.memberLoginEmailTextField.rightAnchor.constraint(equalTo: self.memberLoginView.rightAnchor).isActive = true
        self.memberLoginEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.memberLoginPasswordTextField.topAnchor.constraint(equalTo: self.memberLoginEmailTextField.bottomAnchor, constant: 1).isActive = true
        self.memberLoginPasswordTextField.leftAnchor.constraint(equalTo: self.memberLoginView.leftAnchor).isActive = true
        self.memberLoginPasswordTextField.rightAnchor.constraint(equalTo: self.memberLoginView.rightAnchor).isActive = true
        self.memberLoginPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // MemberViewSignup Constraints
        self.memberSignupView.topAnchor.constraint(equalTo: self.memberNavbar.bottomAnchor).isActive = true
        self.memberSignupView.bottomAnchor.constraint(equalTo: self.memberViewButton.topAnchor).isActive = true
        self.memberSignupView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        self.memberSignupViewRightAnchor = self.memberSignupView.rightAnchor.constraint(equalTo: self.memberView.rightAnchor)
        self.memberSignupViewLeftAnchor = self.memberSignupView.leftAnchor.constraint(equalTo: self.memberView.rightAnchor)
        self.memberSignupViewLeftAnchor?.isActive = true
        
        // MemberViewSignup Component Constraints
        self.memberSignupLabel.topAnchor.constraint(equalTo: self.memberSignupView.topAnchor, constant: 50).isActive = true
        self.memberSignupLabel.centerXAnchor.constraint(equalTo: self.memberSignupView.centerXAnchor).isActive = true
        
        self.memberSignupEmailTextField.topAnchor.constraint(equalTo: self.memberSignupLabel.bottomAnchor, constant: 50).isActive = true
        self.memberSignupEmailTextField.leftAnchor.constraint(equalTo: self.memberSignupView.leftAnchor).isActive = true
        self.memberSignupEmailTextField.rightAnchor.constraint(equalTo: self.memberSignupView.rightAnchor).isActive = true
        self.memberSignupEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.memberSignupPhoneTextField.topAnchor.constraint(equalTo: self.memberSignupEmailTextField.bottomAnchor, constant: 1).isActive = true
        self.memberSignupPhoneTextField.leftAnchor.constraint(equalTo: self.memberSignupView.leftAnchor).isActive = true
        self.memberSignupPhoneTextField.rightAnchor.constraint(equalTo: self.memberSignupView.rightAnchor).isActive = true
        self.memberSignupPhoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.memberSignupPasswordTextField.topAnchor.constraint(equalTo: self.memberSignupPhoneTextField.bottomAnchor, constant: 1).isActive = true
        self.memberSignupPasswordTextField.leftAnchor.constraint(equalTo: self.memberSignupView.leftAnchor).isActive = true
        self.memberSignupPasswordTextField.rightAnchor.constraint(equalTo: self.memberSignupView.rightAnchor).isActive = true
        self.memberSignupPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // MemberSignupView Component constraints
        self.memberSignupNameView.widthAnchor.constraint(equalTo: self.memberView.widthAnchor).isActive = true
        self.memberSignupNameView.topAnchor.constraint(equalTo: self.memberNavbar.bottomAnchor).isActive = true
        self.memberSignupNameView.bottomAnchor.constraint(equalTo: self.memberViewButton.topAnchor).isActive = true
        self.memberSignupNameViewLeftAnchor = self.memberSignupNameView.leftAnchor.constraint(equalTo: self.memberView.rightAnchor)
        self.memberSignupNameViewRightAnchor = self.memberSignupNameView.rightAnchor.constraint(equalTo: self.memberView.rightAnchor)
        self.memberSignupNameViewLeftAnchor?.isActive = true
        
        self.memberSignupNameLabel.topAnchor.constraint(equalTo: self.memberNavbar.bottomAnchor, constant: 50).isActive = true
        self.memberSignupNameLabel.leftAnchor.constraint(equalTo: self.memberSignupNameView.leftAnchor).isActive = true
        self.memberSignupNameLabel.rightAnchor.constraint(equalTo: self.memberSignupNameView.rightAnchor).isActive = true
        
        self.memberSignupFirstNameTextField.topAnchor.constraint(equalTo: self.memberSignupNameLabel.bottomAnchor, constant: 50).isActive = true
        self.memberSignupFirstNameTextField.leftAnchor.constraint(equalTo: self.memberSignupNameView.leftAnchor).isActive = true
        self.memberSignupFirstNameTextField.rightAnchor.constraint(equalTo: self.memberSignupNameView.rightAnchor).isActive = true
        self.memberSignupFirstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.memberSignupLastNameTextField.topAnchor.constraint(equalTo: self.memberSignupFirstNameTextField.bottomAnchor, constant: 1).isActive = true
        self.memberSignupLastNameTextField.leftAnchor.constraint(equalTo: self.memberSignupNameView.leftAnchor).isActive = true
        self.memberSignupLastNameTextField.rightAnchor.constraint(equalTo: self.memberSignupNameView.rightAnchor).isActive = true
        self.memberSignupLastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
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
    /* MemberView Constraint Variables */
    var attorneySignupViewLeftAnchor: NSLayoutConstraint?
    var attorneySignupViewRightAnchor: NSLayoutConstraint?
    var attorneySignupNameViewLeftAnchor: NSLayoutConstraint?
    var attorneySignupNameViewRightAnchor: NSLayoutConstraint?
    /* Initialize MemberViewComponents */
    func initializeAttorneyView() {
        // Add SubViews to View
        self.view.addSubview(self.attorneyView)
        
        // Add SubViews to attorneyview
        self.attorneyView.addSubview(self.attorneyNavbar)
        self.attorneyView.addSubview(self.attorneyViewButton)
        self.attorneyView.addSubview(self.attorneyLoginView)
        self.attorneyView.addSubview(self.attorneySignupView)
        
        // Add Subviews to attorneyloginview
        self.attorneyLoginView.addSubview(self.attorneyLoginLabel)
        self.attorneyLoginView.addSubview(self.attorneyLoginPasswordTextField)
        self.attorneyLoginView.addSubview(self.attorneyLoginEmailTextField)
        
        // Add Subviews to attorneysignupview
        self.attorneySignupView.addSubview(self.attorneySignupLabel)
        self.attorneySignupView.addSubview(self.attorneySignupEmailTextField)
        self.attorneySignupView.addSubview(self.attorneySignupPhoneTextField)
        self.attorneySignupView.addSubview(self.attorneySignupPasswordTextField)
        
        // Add Subviews to attorneysignupnameview
        self.attorneyView.addSubview(self.attorneySignupNameView)
        self.attorneySignupNameView.addSubview(self.attorneySignupNameLabel)
        self.attorneySignupNameView.addSubview(self.attorneySignupFirstNameTextField)
        self.attorneySignupNameView.addSubview(self.attorneySignupLastNameTextField)
        self.attorneySignupNameView.addSubview(self.attorneySignupBarNumberTextField)
        
        // Constraints
        self.attorneyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.attorneyView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.attorneyView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.attorneyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // navbar constraints
        self.attorneyNavbar.leftAnchor.constraint(equalTo: self.attorneyView.leftAnchor).isActive = true
        self.attorneyNavbar.rightAnchor.constraint(equalTo: self.attorneyView.rightAnchor).isActive = true
        self.attorneyNavbar.topAnchor.constraint(equalTo: self.attorneyView.topAnchor).isActive = true
        
        // MemberView bottom button
        self.attorneyViewButton.bottomAnchor.constraint(equalTo: self.attorneyView.bottomAnchor, constant: -50).isActive = true
        self.attorneyViewButton.centerXAnchor.constraint(equalTo: self.attorneyView.centerXAnchor).isActive = true
        self.attorneyViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyViewButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        // MemberViewLogin Constraints
        self.attorneyLoginView.topAnchor.constraint(equalTo: self.attorneyNavbar.bottomAnchor).isActive = true
        self.attorneyLoginView.bottomAnchor.constraint(equalTo: self.attorneyViewButton.topAnchor).isActive = true
        self.attorneyLoginView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        self.attorneyLoginView.rightAnchor.constraint(equalTo: self.attorneyView.rightAnchor).isActive = true
        
        // MemberViewLogin Component Constraints
        self.attorneyLoginLabel.topAnchor.constraint(equalTo: self.attorneyLoginView.topAnchor, constant: 50).isActive = true
        self.attorneyLoginLabel.centerXAnchor.constraint(equalTo: self.attorneyLoginView.centerXAnchor).isActive = true
        
        self.attorneyLoginEmailTextField.topAnchor.constraint(equalTo: self.attorneyLoginLabel.bottomAnchor, constant: 50).isActive = true
        self.attorneyLoginEmailTextField.leftAnchor.constraint(equalTo: self.attorneyLoginView.leftAnchor).isActive = true
        self.attorneyLoginEmailTextField.rightAnchor.constraint(equalTo: self.attorneyLoginView.rightAnchor).isActive = true
        self.attorneyLoginEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.attorneyLoginPasswordTextField.topAnchor.constraint(equalTo: self.attorneyLoginEmailTextField.bottomAnchor, constant: 1).isActive = true
        self.attorneyLoginPasswordTextField.leftAnchor.constraint(equalTo: self.attorneyLoginView.leftAnchor).isActive = true
        self.attorneyLoginPasswordTextField.rightAnchor.constraint(equalTo: self.attorneyLoginView.rightAnchor).isActive = true
        self.attorneyLoginPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // AttorneyViewSignup Constraints
        self.attorneySignupView.topAnchor.constraint(equalTo: self.attorneyNavbar.bottomAnchor).isActive = true
        self.attorneySignupView.bottomAnchor.constraint(equalTo: self.attorneyViewButton.topAnchor).isActive = true
        self.attorneySignupView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        self.attorneySignupViewRightAnchor = self.attorneySignupView.rightAnchor.constraint(equalTo: self.attorneyView.leftAnchor)
        self.attorneySignupViewLeftAnchor = self.attorneySignupView.leftAnchor.constraint(equalTo: self.attorneyView.leftAnchor)
        self.attorneySignupViewRightAnchor?.isActive = true
        
        // AttorneyViewSignup Component Constraints
        self.attorneySignupLabel.topAnchor.constraint(equalTo: self.attorneySignupView.topAnchor, constant: 50).isActive = true
        self.attorneySignupLabel.centerXAnchor.constraint(equalTo: self.attorneySignupView.centerXAnchor).isActive = true
        
        self.attorneySignupEmailTextField.topAnchor.constraint(equalTo: self.attorneySignupLabel.bottomAnchor, constant: 50).isActive = true
        self.attorneySignupEmailTextField.leftAnchor.constraint(equalTo: self.attorneySignupView.leftAnchor).isActive = true
        self.attorneySignupEmailTextField.rightAnchor.constraint(equalTo: self.attorneySignupView.rightAnchor).isActive = true
        self.attorneySignupEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.attorneySignupPhoneTextField.topAnchor.constraint(equalTo: self.attorneySignupEmailTextField.bottomAnchor, constant: 1).isActive = true
        self.attorneySignupPhoneTextField.leftAnchor.constraint(equalTo: self.attorneySignupView.leftAnchor).isActive = true
        self.attorneySignupPhoneTextField.rightAnchor.constraint(equalTo: self.attorneySignupView.rightAnchor).isActive = true
        self.attorneySignupPhoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.attorneySignupPasswordTextField.topAnchor.constraint(equalTo: self.attorneySignupPhoneTextField.bottomAnchor, constant: 1).isActive = true
        self.attorneySignupPasswordTextField.leftAnchor.constraint(equalTo: self.attorneySignupView.leftAnchor).isActive = true
        self.attorneySignupPasswordTextField.rightAnchor.constraint(equalTo: self.attorneySignupView.rightAnchor).isActive = true
        self.attorneySignupPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //  AttorneySignupName View Constraints
        self.attorneySignupNameView.bottomAnchor.constraint(equalTo: self.attorneyViewButton.topAnchor).isActive = true
        self.attorneySignupNameView.topAnchor.constraint(equalTo: self.attorneyNavbar.bottomAnchor).isActive = true
        self.attorneySignupNameView.widthAnchor.constraint(equalTo: self.attorneyView.widthAnchor).isActive = true
        self.attorneySignupNameViewLeftAnchor = self.attorneySignupNameView.leftAnchor.constraint(equalTo: self.attorneyView.leftAnchor)
        self.attorneySignupNameViewRightAnchor = self.attorneySignupNameView.rightAnchor.constraint(equalTo: self.attorneyView.leftAnchor)
        self.attorneySignupNameViewRightAnchor?.isActive = true
        
        self.attorneySignupNameLabel.topAnchor.constraint(equalTo: self.attorneyNavbar.bottomAnchor, constant: 50).isActive = true
        self.attorneySignupNameLabel.centerXAnchor.constraint(equalTo: self.attorneySignupNameView.centerXAnchor).isActive = true
        
        self.attorneySignupFirstNameTextField.topAnchor.constraint(equalTo: self.attorneySignupNameLabel.bottomAnchor, constant: 50).isActive = true
        self.attorneySignupFirstNameTextField.leftAnchor.constraint(equalTo: self.attorneySignupNameView.leftAnchor).isActive = true
        self.attorneySignupFirstNameTextField.rightAnchor.constraint(equalTo: self.attorneySignupNameView.rightAnchor).isActive = true
        self.attorneySignupFirstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.attorneySignupLastNameTextField.topAnchor.constraint(equalTo: self.attorneySignupFirstNameTextField.bottomAnchor, constant: 1).isActive = true
        self.attorneySignupLastNameTextField.leftAnchor.constraint(equalTo: self.attorneySignupNameView.leftAnchor).isActive = true
        self.attorneySignupLastNameTextField.rightAnchor.constraint(equalTo: self.attorneySignupNameView.rightAnchor).isActive = true
        self.attorneySignupLastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.attorneySignupBarNumberTextField.topAnchor.constraint(equalTo: self.attorneySignupLastNameTextField.bottomAnchor, constant: 1).isActive = true
        self.attorneySignupBarNumberTextField.leftAnchor.constraint(equalTo: self.attorneySignupNameView.leftAnchor).isActive = true
        self.attorneySignupBarNumberTextField.rightAnchor.constraint(equalTo: self.attorneySignupNameView.rightAnchor).isActive = true
        self.attorneySignupBarNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    /* Animates the alpha changes in attorneyview */
    func animateAttorneyViewShow() {
        self.attorneyViewButton.setTitle("Signup", for: .normal)
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
    /* UI Manip */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

