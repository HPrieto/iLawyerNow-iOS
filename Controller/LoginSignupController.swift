//
//  LoginSignupController.swift
//  iLawyer
//
//  Created by Heriberto Prieto on 11/25/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

class LoginSignupController: UIViewController, UIScrollViewDelegate {
    
    /* Global Constants */
    let TEAL = UIColor(r: 19, g: 136, b: 143)
    let DISAPPEAR:CGFloat = 0.0
    let APPEAR:CGFloat = 1.0
    let INSTANT:Double = 0.0
    let RAPID:Double = 0.40
    let GRADUAL:Double = 0.5
    let SLOWLY:Double = 0.75
    let VERYSLOW:Double = 1.0
    let INVIEW:CGFloat = 0.0
    var OFFVIEW = CGFloat() // not a constant but whatevs, initialized in viewdidload
    let DISABLED:CGFloat = 0.75
    let ENABLED:CGFloat = 1.0
    
    /* AttorneyView Margin Variables */
    var attorneySignupNameScrollViewHeightAnchor: NSLayoutConstraint?
    var attorneySignupEmailScrollViewHeightAnchor: NSLayoutConstraint?
    var attorneySignupNameScrollViewLeftAnchor: NSLayoutConstraint?
    var attorneySignupEmailScrollViewLeftAnchor: NSLayoutConstraint?
    
    /* MemberView Margin Variables */
    var memberSignupNameScrollViewHeightAnchor: NSLayoutConstraint?
    var memberSignupEmailScrollViewHeightAnchor: NSLayoutConstraint?
    var memberSignupNameScrollViewLeftAnchor: NSLayoutConstraint?
    var memberSignupEmailScrollViewLeftAnchor: NSLayoutConstraint?
    
    /* DirectoryView Components */
    let welcomeNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.barTintColor = UIColor.clear
        navbar.backgroundColor = UIColor.clear
        navbar.tintColor = UIColor.white
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    let welcomeNavbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.rightBarButtonItem = UIBarButtonItem(title: "Login", style: UIBarButtonItemStyle.plain, target: self, action: #selector(welcomeNavbarRightButtonClicked))
        navItems.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 16)!], for: .normal)
        return navItems
    }()
    
    let welcomeView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ilawyerIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "ilawyer_home_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let memberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Member", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 20)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(memberButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let attorneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Attorney", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 20)
        button.setTitleColor(UIColor(red:0.38, green:0.26, blue:0.52, alpha:1.0), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(attorneyButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome \nto iLawyerNow."
        label.font = UIFont(name: "AvenirNext-Regular", size: 30)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.90)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /* Login Components */
    let loginView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let loginNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.barTintColor = UIColor.clear
        navbar.backgroundColor = UIColor.clear
        navbar.tintColor = UIColor.white
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    let loginNavbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left_arrow"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(loginNavbarLeftButtonClicked))
        navItems.rightBarButtonItem = UIBarButtonItem(title: "Forgot Password", style: UIBarButtonItemStyle.plain, target: self, action: #selector(loginNavbarRightButtonClicked))
        navItems.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "AvenirNext-Medium", size: 16)!], for: .normal)
        return navItems
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginEmailTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "EMAIL ADDRESS"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginPasswordTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "PASSWORD"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginEmailTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(loginFields), for: .editingChanged)
        return textField
    }()
    
    let loginPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(loginFields), for: .editingChanged)
        return textField
    }()
    
    /* AttorneyView Margins */
    let attorneyView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let attorneyNameScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let attorneyNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.barTintColor = UIColor.clear
        navbar.backgroundColor = UIColor.clear
        navbar.tintColor = UIColor.white
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    let attorneyNavbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left_arrow"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(attorneyNavbarLeftButtonClicked))
        return navItems
    }()
    
    let attorneyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your name?"
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyFirstNameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "FIRST NAME"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyLastNameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "LAST NAME"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyPhoneTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "PHONE NUMBER"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyFirstNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let attorneyLastNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let attorneyPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.phonePad
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    /* Attorney Email Components */
    let attorneyEmailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let attorneyEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "And, your email?"
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyEmailTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "EMAIL"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyPasswordTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "PASSWORD"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyBarTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "BAR NUMBER"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let attorneyEmailTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let attorneyPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let attorneyBarTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    var attorneyNameToEmailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.contentMode = .scaleAspectFit
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(UIImage(named: "right_arrow_purple"), for: .normal)
        button.addTarget(self, action: #selector(attorneyNameToEmailButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /* MemberView Margins */
    let memberView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let memberNameScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let memberNavbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.barStyle = .default
        navbar.barTintColor = UIColor.clear
        navbar.backgroundColor = UIColor.clear
        navbar.tintColor = UIColor.white
        navbar.isTranslucent = true
        navbar.isOpaque = false
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    let memberNavbarItems: UINavigationItem = {
        let navItems = UINavigationItem()
        navItems.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left_arrow"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(memberNavbarLeftButtonClicked))
        return navItems
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your name?"
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberFirstNameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "FIRST NAME"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberLastNameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "LAST NAME"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberPhoneTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "PHONE NUMBER"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberFirstNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let memberLastNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let memberPhoneTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.phonePad
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    /* Member Email Components */
    let memberEmailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.tintColor = UIColor.white
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let memberEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "And, your email?"
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Regular", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberEmailTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "EMAIL"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberPasswordTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "PASSWORD"
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memberEmailTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    let memberPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.alphabet
        textField.font = UIFont(name: "AvenirNext-DemiBold", size: 21)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(attorneyFields), for: .editingChanged)
        return textField
    }()
    
    var memberNameToEmailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.contentMode = .scaleAspectFit
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(UIImage(named: "right_arrow_purple"), for: .normal)
        button.addTarget(self, action: #selector(memberNameToEmailButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.75
        button.isEnabled = false
        return button
    }()
    
    var memberSignupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.contentMode = .scaleAspectFit
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "right_arrow_purple"), for: .normal)
        button.addTarget(self, action: #selector(memberSignupButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.75
        button.isEnabled = false
        return button
    }()
    
    var attorneySignupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.contentMode = .scaleAspectFit
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "right_arrow_purple"), for: .normal)
        button.addTarget(self, action: #selector(attorneySignupButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.75
        button.isEnabled = false
        return button
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.contentMode = .scaleAspectFit
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "right_arrow_purple"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.75
        button.isEnabled = false
        return button
    }()
    
    func disableLoginButton() {
        self.loginButton.alpha = self.DISABLED
        self.loginButton.isEnabled = false
    }
    
    func enableLoginButton() {
        self.loginButton.alpha = self.ENABLED
        self.loginButton.isEnabled = true
    }
    
    func disableAttorneyNameToEmailButton() {
        self.attorneyNameToEmailButton.alpha = self.DISABLED
        self.attorneyNameToEmailButton.isEnabled = false
    }
    
    func enableAttorneyNameToEmailButton() {
        self.attorneyNameToEmailButton.alpha = self.ENABLED
        self.attorneyNameToEmailButton.isEnabled = true
    }
    
    func disableMemberNameToEmailButton() {
        self.memberNameToEmailButton.alpha = self.DISABLED
        self.memberNameToEmailButton.isEnabled = false
    }
    
    func enableMemberNameToEmailButton() {
        self.memberNameToEmailButton.alpha = self.ENABLED
        self.memberNameToEmailButton.isEnabled = true
    }
    
    func disableMemberSignupButton() {
        self.memberSignupButton.alpha = self.DISABLED
        self.memberSignupButton.isEnabled = false
    }
    
    func enableMemberSignupButton() {
        self.memberSignupButton.alpha = self.ENABLED
        self.memberSignupButton.isEnabled = true
    }
    
    func disableAttorneySignupButton() {
        self.attorneySignupButton.alpha = self.DISABLED
        self.attorneySignupButton.isEnabled = false
    }
    
    func popThisView() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: false)
    }
    
    /* Controller Lifecycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        self.OFFVIEW = self.view.bounds.width
        self.setGradientBackground()
        self.welcomeNavbar.setItems([self.welcomeNavbarItems], animated: false)
        self.loginNavbar.setItems([self.loginNavbarItems], animated: false)
        self.attorneyNavbar.setItems([self.attorneyNavbarItems], animated: false)
        self.memberNavbar.setItems([self.memberNavbarItems], animated: false)
        self.initializeView()
        self.initializeLoginView()
        self.initializeMemberView()
        self.initializeAttorneyView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setGradientBackground() {
        //let colorTop =  UIColor(red:0.04, green:0.13, blue:0.25, alpha:1.0).cgColor
        let colorTop = UIColor(red:0.38, green:0.26, blue:0.52, alpha:1.0).cgColor
        //let colorBottom = UIColor(red:0.33, green:0.47, blue:0.58, alpha:1.0).cgColor
        let colorBottom = UIColor(red:0.32, green:0.39, blue:0.58, alpha:1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    /* Initialize View */
    func initializeView() {
        self.view.addSubview(self.welcomeView)
        
        // Add buttons to view
        self.welcomeView.addSubview(self.welcomeNavbar)
        self.welcomeView.addSubview(self.ilawyerIcon)
        self.welcomeView.addSubview(self.welcomeLabel)
        self.welcomeView.addSubview(self.memberButton)
        self.welcomeView.addSubview(self.attorneyButton)
        
        // Welcome View Margins
        self.welcomeView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.welcomeView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.welcomeView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.welcomeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Welcome Navbar Margins
        self.welcomeNavbar.topAnchor.constraint(equalTo: self.welcomeView.topAnchor).isActive = true
        self.welcomeNavbar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.welcomeNavbar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        // iLawyerIcon Margins
        self.ilawyerIcon.bottomAnchor.constraint(equalTo: self.welcomeLabel.topAnchor, constant: -50).isActive = true
        self.ilawyerIcon.leftAnchor.constraint(equalTo: self.welcomeView.leftAnchor, constant: 20).isActive = true
        self.ilawyerIcon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.ilawyerIcon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        // Welcome Label Margins
        self.welcomeLabel.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.welcomeLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.welcomeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        
        // Welcome Attorney Button Margin
        self.attorneyButton.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 50).isActive = true
        self.attorneyButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.attorneyButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.attorneyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Welcome Member Button Margin
        self.memberButton.topAnchor.constraint(equalTo: self.attorneyButton.bottomAnchor, constant: 15).isActive = true
        self.memberButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.memberButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.memberButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    var loginScrollViewHeightAnchor: NSLayoutConstraint?
    func initializeLoginView() {
        self.view.addSubview(self.loginView)
        self.loginView.addSubview(self.loginNavbar)
        self.loginView.addSubview(self.loginScrollView)
        self.loginScrollView.addSubview(self.loginLabel)
        self.loginScrollView.addSubview(self.loginEmailTextFieldLabel)
        self.loginScrollView.addSubview(self.loginEmailTextField)
        self.loginScrollView.addSubview(self.loginPasswordTextFieldLabel)
        self.loginScrollView.addSubview(self.loginPasswordTextField)
        self.loginView.addSubview(self.loginButton)
        
        // LoginView Margins
        self.loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.loginView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Navbar Margins
        self.loginNavbar.leftAnchor.constraint(equalTo: self.loginView.leftAnchor).isActive = true
        self.loginNavbar.rightAnchor.constraint(equalTo: self.loginView.rightAnchor).isActive = true
        self.loginNavbar.topAnchor.constraint(equalTo: self.loginView.topAnchor, constant: 20).isActive = true
        
        // LoginScrollView Margins
        self.loginScrollView.leftAnchor.constraint(equalTo: self.loginView.leftAnchor).isActive = true
        self.loginScrollView.rightAnchor.constraint(equalTo: self.loginView.rightAnchor).isActive = true
        self.loginScrollView.topAnchor.constraint(equalTo: self.loginView.topAnchor, constant: 60).isActive = true
        self.loginScrollViewHeightAnchor = self.loginScrollView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)
        self.loginScrollViewHeightAnchor?.isActive = true
        self.loginScrollView.delegate = self
        self.loginScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 450)
        
        // Login Label Margins
        self.loginLabel.topAnchor.constraint(equalTo: self.loginScrollView.bottomAnchor, constant: 40).isActive = true
        self.loginLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.loginLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        
        // Login Email Label Margins
        self.loginEmailTextFieldLabel.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 40).isActive = true
        self.loginEmailTextFieldLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.loginEmailTextFieldLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        
        // Login Email Textfield Margins
        self.loginEmailTextField.topAnchor.constraint(equalTo: self.loginEmailTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.loginEmailTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.loginEmailTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.loginEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Login Password Label Margins
        self.loginPasswordTextFieldLabel.topAnchor.constraint(equalTo: self.loginEmailTextField.bottomAnchor, constant: 10).isActive = true
        self.loginPasswordTextFieldLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.loginPasswordTextFieldLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        
        // Login Password Textfield Margins
        self.loginPasswordTextField.topAnchor.constraint(equalTo: self.loginPasswordTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.loginPasswordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.loginPasswordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.loginPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Login Button
        self.loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.loginButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.loginButtonBottomMargin = self.loginButton.bottomAnchor.constraint(equalTo: self.loginView.bottomAnchor, constant: -25)
        self.loginButtonBottomMargin?.isActive = true
        self.loginButton.rightAnchor.constraint(equalTo: self.loginView.rightAnchor, constant: -20).isActive = true
    }
    
    var loginButtonBottomMargin: NSLayoutConstraint?
    
    /*
     var attorneySignupNameScrollViewHeightAnchor: NSLayoutConstraint?
     var attorneySignupEmailScrollViewHeightAnchor: NSLayoutConstraint?
     var attorneySignupNameScrollViewLeftAnchor: NSLayoutConstraint?
    */
    func initializeAttorneyView() {
        // Add SubViews to View
        self.view.addSubview(self.attorneyView)
        self.attorneyView.addSubview(self.attorneyNavbar)
        
        // Attorney NameView
        self.attorneyView.addSubview(self.attorneyNameScrollView)
        self.attorneyNameScrollView.addSubview(self.attorneyNameLabel)
        self.attorneyNameScrollView.addSubview(self.attorneyFirstNameTextFieldLabel)
        self.attorneyNameScrollView.addSubview(self.attorneyFirstNameTextField)
        self.attorneyNameScrollView.addSubview(self.attorneyLastNameTextFieldLabel)
        self.attorneyNameScrollView.addSubview(self.attorneyLastNameTextField)
        self.attorneyNameScrollView.addSubview(self.attorneyPhoneTextFieldLabel)
        self.attorneyNameScrollView.addSubview(self.attorneyPhoneTextField)
        
        // Attorney EmailView
        self.attorneyView.addSubview(self.attorneyEmailScrollView)
        self.attorneyEmailScrollView.addSubview(self.attorneyEmailLabel)
        self.attorneyEmailScrollView.addSubview(self.attorneyBarTextFieldLabel)
        self.attorneyEmailScrollView.addSubview(self.attorneyBarTextField)
        self.attorneyEmailScrollView.addSubview(self.attorneyEmailTextFieldLabel)
        self.attorneyEmailScrollView.addSubview(self.attorneyEmailTextField)
        self.attorneyEmailScrollView.addSubview(self.attorneyPasswordTextFieldLabel)
        self.attorneyEmailScrollView.addSubview(self.attorneyPasswordTextField)
        
        // Attorney Buttons
        self.attorneyView.addSubview(self.attorneyNameToEmailButton)
        self.attorneyView.addSubview(self.attorneySignupButton)
        
        // AttorneyView Margins
        self.attorneyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.attorneyView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.attorneyView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.attorneyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Navbar Margins
        self.attorneyNavbar.leftAnchor.constraint(equalTo: self.attorneyView.leftAnchor).isActive = true
        self.attorneyNavbar.rightAnchor.constraint(equalTo: self.attorneyView.rightAnchor).isActive = true
        self.attorneyNavbar.topAnchor.constraint(equalTo: self.attorneyView.topAnchor, constant: 20).isActive = true
        
        // AttorneyNameScrollView Margins
        self.attorneyNameScrollView.widthAnchor.constraint(equalTo: self.attorneyView.widthAnchor).isActive = true
        self.attorneySignupNameScrollViewLeftAnchor = self.attorneyNameScrollView.leftAnchor.constraint(equalTo: self.attorneyView.leftAnchor, constant: self.view.bounds.width)
        self.attorneySignupNameScrollViewLeftAnchor?.isActive = true
        self.attorneyNameScrollView.topAnchor.constraint(equalTo: self.attorneyView.topAnchor, constant: 60).isActive = true
        self.attorneySignupNameScrollViewHeightAnchor = self.attorneyNameScrollView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)
        self.attorneySignupNameScrollViewHeightAnchor?.isActive = true
        self.attorneyNameScrollView.delegate = self
        self.attorneyNameScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 550)
        
        // Attorney Name Label
        self.attorneyNameLabel.topAnchor.constraint(equalTo: self.attorneyNameScrollView.bottomAnchor, constant: 40).isActive = true
        self.attorneyNameLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyNameLabel.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        // Attorney FirstName TextField Label
        self.attorneyFirstNameTextFieldLabel.topAnchor.constraint(equalTo: self.attorneyNameLabel.bottomAnchor, constant: 40).isActive = true
        self.attorneyFirstNameTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyFirstNameTextFieldLabel.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        // Attorney FirstName TextField
        self.attorneyFirstNameTextField.topAnchor.constraint(equalTo: self.attorneyFirstNameTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.attorneyFirstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyFirstNameTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyFirstNameTextField.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        // Attorney LastName TextField Label
        self.attorneyLastNameTextFieldLabel.topAnchor.constraint(equalTo: self.attorneyFirstNameTextField.bottomAnchor, constant: 10).isActive = true
        self.attorneyLastNameTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyLastNameTextFieldLabel.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        // Attorney LastName TextField
        self.attorneyLastNameTextField.topAnchor.constraint(equalTo: self.attorneyLastNameTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.attorneyLastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyLastNameTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyLastNameTextField.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        // Attorney Phone TextField Label
        self.attorneyPhoneTextFieldLabel.topAnchor.constraint(equalTo: self.attorneyLastNameTextField.bottomAnchor, constant: 10).isActive = true
        self.attorneyPhoneTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyPhoneTextFieldLabel.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        // Attorney Phone TextField
        self.attorneyPhoneTextField.topAnchor.constraint(equalTo: self.attorneyPhoneTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.attorneyPhoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyPhoneTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyPhoneTextField.centerXAnchor.constraint(equalTo: self.attorneyNameScrollView.centerXAnchor).isActive = true
        
        /*
         AttorneyEmailScrollView Margins
        */
        self.attorneyEmailScrollView.widthAnchor.constraint(equalTo: self.attorneyView.widthAnchor).isActive = true
        self.attorneySignupEmailScrollViewLeftAnchor = self.attorneyEmailScrollView.leftAnchor.constraint(equalTo: self.attorneyView.leftAnchor, constant: self.view.bounds.width)
        self.attorneySignupEmailScrollViewLeftAnchor?.isActive = true
        self.attorneyEmailScrollView.topAnchor.constraint(equalTo: self.attorneyView.topAnchor, constant: 60).isActive = true
        self.attorneySignupEmailScrollViewHeightAnchor = self.attorneyEmailScrollView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)
        self.attorneySignupEmailScrollViewHeightAnchor?.isActive = true
        self.attorneyEmailScrollView.delegate = self
        self.attorneyEmailScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 550)
        
        // Attorney Email Label
        self.attorneyEmailLabel.topAnchor.constraint(equalTo: self.attorneyEmailScrollView.bottomAnchor, constant: 40).isActive = true
        self.attorneyEmailLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyEmailLabel.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        // Attorney Bar Number TextField Label
        self.attorneyBarTextFieldLabel.topAnchor.constraint(equalTo: self.attorneyEmailLabel.bottomAnchor, constant: 40).isActive = true
        self.attorneyBarTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyBarTextFieldLabel.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        // Attorney Bar TextField
        self.attorneyBarTextField.topAnchor.constraint(equalTo: self.attorneyBarTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.attorneyBarTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyBarTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyBarTextField.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        // Attorney Email TextField Label
        self.attorneyEmailTextFieldLabel.topAnchor.constraint(equalTo: self.attorneyBarTextField.bottomAnchor, constant: 10).isActive = true
        self.attorneyEmailTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyEmailTextFieldLabel.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        // Attorney Email TextField
        self.attorneyEmailTextField.topAnchor.constraint(equalTo: self.attorneyEmailTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.attorneyEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyEmailTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyEmailTextField.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        // Attorney Password TextField Label
        self.attorneyPasswordTextFieldLabel.topAnchor.constraint(equalTo: self.attorneyEmailTextField.bottomAnchor, constant: 10).isActive = true
        self.attorneyPasswordTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyPasswordTextFieldLabel.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        // Attorney Password TextField
        self.attorneyPasswordTextField.topAnchor.constraint(equalTo: self.attorneyPasswordTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.attorneyPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyPasswordTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.attorneyPasswordTextField.centerXAnchor.constraint(equalTo: self.attorneyEmailScrollView.centerXAnchor).isActive = true
        
        /*
         Attorney Button Margins
         */
        self.attorneyNameToEmailButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        self.attorneyNameToEmailButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneyNameToEmailButtonBottomMargin = self.attorneyNameToEmailButton.bottomAnchor.constraint(equalTo: self.attorneyView.bottomAnchor, constant: -25)
        self.attorneyNameToEmailButtonBottomMargin?.isActive = true
        self.attorneyNameToEmailButton.rightAnchor.constraint(equalTo: self.attorneyView.rightAnchor, constant: -20).isActive = true
        
        self.attorneySignupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneySignupButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.attorneySignupButtonBottomMargin = self.attorneySignupButton.bottomAnchor.constraint(equalTo: self.attorneyView.bottomAnchor, constant: -25)
        self.attorneySignupButtonBottomMargin?.isActive = true
        self.attorneySignupButton.rightAnchor.constraint(equalTo: self.attorneyView.rightAnchor, constant: -20).isActive = true
    }
    var attorneyNameToEmailButtonBottomMargin: NSLayoutConstraint?
    var attorneySignupButtonBottomMargin: NSLayoutConstraint?
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func initializeMemberView() {
        // Add SubViews to View
        self.view.addSubview(self.memberView)
        self.memberView.addSubview(self.memberNavbar)
        
        // Member NameView
        self.memberView.addSubview(self.memberNameScrollView)
        self.memberNameScrollView.addSubview(self.memberNameLabel)
        self.memberNameScrollView.addSubview(self.memberFirstNameTextFieldLabel)
        self.memberNameScrollView.addSubview(self.memberFirstNameTextField)
        self.memberNameScrollView.addSubview(self.memberLastNameTextFieldLabel)
        self.memberNameScrollView.addSubview(self.memberLastNameTextField)
        self.memberNameScrollView.addSubview(self.memberPhoneTextFieldLabel)
        self.memberNameScrollView.addSubview(self.memberPhoneTextField)
        
        // Member EmailView
        self.memberView.addSubview(self.memberEmailScrollView)
        self.memberEmailScrollView.addSubview(self.memberEmailLabel)
        self.memberEmailScrollView.addSubview(self.memberEmailTextFieldLabel)
        self.memberEmailScrollView.addSubview(self.memberEmailTextField)
        self.memberEmailScrollView.addSubview(self.memberPasswordTextFieldLabel)
        self.memberEmailScrollView.addSubview(self.memberPasswordTextField)
        
        // Member Buttons
        self.memberView.addSubview(self.memberNameToEmailButton)
        self.memberView.addSubview(self.memberSignupButton)
        
        // MemberView Margins
        self.memberView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.memberView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.memberView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.memberView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Navbar Margins
        self.memberNavbar.leftAnchor.constraint(equalTo: self.memberView.leftAnchor).isActive = true
        self.memberNavbar.rightAnchor.constraint(equalTo: self.memberView.rightAnchor).isActive = true
        self.memberNavbar.topAnchor.constraint(equalTo: self.memberView.topAnchor, constant: 20).isActive = true
        
        // MemberNameScrollView Margins
        self.memberNameScrollView.widthAnchor.constraint(equalTo: self.memberView.widthAnchor).isActive = true
        self.memberSignupNameScrollViewLeftAnchor = self.memberNameScrollView.leftAnchor.constraint(equalTo: self.memberView.leftAnchor, constant: self.view.bounds.width)
        self.memberSignupNameScrollViewLeftAnchor?.isActive = true
        self.memberNameScrollView.topAnchor.constraint(equalTo: self.memberView.topAnchor, constant: 60).isActive = true
        self.memberSignupNameScrollViewHeightAnchor = self.memberNameScrollView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)
        self.memberSignupNameScrollViewHeightAnchor?.isActive = true
        self.memberNameScrollView.delegate = self
        self.memberNameScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 550)
        
        // Member Name Label
        self.memberNameLabel.topAnchor.constraint(equalTo: self.memberNameScrollView.bottomAnchor, constant: 40).isActive = true
        self.memberNameLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberNameLabel.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        // Member FirstName TextField Label
        self.memberFirstNameTextFieldLabel.topAnchor.constraint(equalTo: self.memberNameLabel.bottomAnchor, constant: 40).isActive = true
        self.memberFirstNameTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberFirstNameTextFieldLabel.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        // Member FirstName TextField
        self.memberFirstNameTextField.topAnchor.constraint(equalTo: self.memberFirstNameTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.memberFirstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberFirstNameTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberFirstNameTextField.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        // Member LastName TextField Label
        self.memberLastNameTextFieldLabel.topAnchor.constraint(equalTo: self.memberFirstNameTextField.bottomAnchor, constant: 10).isActive = true
        self.memberLastNameTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberLastNameTextFieldLabel.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        // Member LastName TextField
        self.memberLastNameTextField.topAnchor.constraint(equalTo: self.memberLastNameTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.memberLastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberLastNameTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberLastNameTextField.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        // Member Phone TextField Label
        self.memberPhoneTextFieldLabel.topAnchor.constraint(equalTo: self.memberLastNameTextField.bottomAnchor, constant: 10).isActive = true
        self.memberPhoneTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberPhoneTextFieldLabel.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        // Member Phone TextField
        self.memberPhoneTextField.topAnchor.constraint(equalTo: self.memberPhoneTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.memberPhoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberPhoneTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberPhoneTextField.centerXAnchor.constraint(equalTo: self.memberNameScrollView.centerXAnchor).isActive = true
        
        /*
         MemberEmailScrollView Margins
         */
        self.memberEmailScrollView.widthAnchor.constraint(equalTo: self.memberView.widthAnchor).isActive = true
        self.memberSignupEmailScrollViewLeftAnchor = self.memberEmailScrollView.leftAnchor.constraint(equalTo: self.memberView.leftAnchor, constant: self.view.bounds.width)
        self.memberSignupEmailScrollViewLeftAnchor?.isActive = true
        self.memberEmailScrollView.topAnchor.constraint(equalTo: self.memberView.topAnchor, constant: 60).isActive = true
        self.memberSignupEmailScrollViewHeightAnchor = self.memberEmailScrollView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)
        self.memberSignupEmailScrollViewHeightAnchor?.isActive = true
        self.memberEmailScrollView.delegate = self
        self.memberEmailScrollView.contentSize = CGSize(width: self.view.bounds.width, height: 450)
        
        // Member Email Label
        self.memberEmailLabel.topAnchor.constraint(equalTo: self.memberEmailScrollView.bottomAnchor, constant: 40).isActive = true
        self.memberEmailLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberEmailLabel.centerXAnchor.constraint(equalTo: self.memberEmailScrollView.centerXAnchor).isActive = true
        
        // Member Email TextField Label
        self.memberEmailTextFieldLabel.topAnchor.constraint(equalTo: self.memberEmailLabel.bottomAnchor, constant: 40).isActive = true
        self.memberEmailTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberEmailTextFieldLabel.centerXAnchor.constraint(equalTo: self.memberEmailScrollView.centerXAnchor).isActive = true
        
        // Member Email TextField
        self.memberEmailTextField.topAnchor.constraint(equalTo: self.memberEmailTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.memberEmailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberEmailTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberEmailTextField.centerXAnchor.constraint(equalTo: self.memberEmailScrollView.centerXAnchor).isActive = true
        
        // Member Password TextField Label
        self.memberPasswordTextFieldLabel.topAnchor.constraint(equalTo: self.memberEmailTextField.bottomAnchor, constant: 10).isActive = true
        self.memberPasswordTextFieldLabel.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberPasswordTextFieldLabel.centerXAnchor.constraint(equalTo: self.memberEmailScrollView.centerXAnchor).isActive = true
        
        // Member Password TextField
        self.memberPasswordTextField.topAnchor.constraint(equalTo: self.memberPasswordTextFieldLabel.bottomAnchor, constant: 5).isActive = true
        self.memberPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberPasswordTextField.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 40).isActive = true
        self.memberPasswordTextField.centerXAnchor.constraint(equalTo: self.memberEmailScrollView.centerXAnchor).isActive = true
        
        /*
         Member Button Margins
         */
        self.memberNameToEmailButton.heightAnchor.constraint(equalToConstant:50).isActive = true
        self.memberNameToEmailButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberNameToEmailButtonBottomMargin = self.memberNameToEmailButton.bottomAnchor.constraint(equalTo: self.memberView.bottomAnchor, constant: -25)
        self.memberNameToEmailButtonBottomMargin?.isActive = true
        self.memberNameToEmailButton.rightAnchor.constraint(equalTo: self.memberView.rightAnchor, constant: -20).isActive = true
        
        self.memberSignupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberSignupButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.memberSignupButtonBottomMargin = self.memberSignupButton.bottomAnchor.constraint(equalTo: self.memberView.bottomAnchor, constant: -25)
        self.memberSignupButtonBottomMargin?.isActive = true
        self.memberSignupButton.rightAnchor.constraint(equalTo: self.memberView.rightAnchor, constant: -20).isActive = true
    }
    var memberNameToEmailButtonBottomMargin: NSLayoutConstraint?
    var memberSignupButtonBottomMargin: NSLayoutConstraint?
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    
    /* UI Manip */
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

