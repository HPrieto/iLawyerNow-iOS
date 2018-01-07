//
//  PhoneViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/19/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {

    /* Global Constants */
    let PHONEREGEX = "^[0-9]{8}$"
    /* UIComponents */
    let phoneView: UIView = {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = UIColor.white
        newView.layer.borderWidth = 1
        newView.layer.borderColor = UIColor.lightGray.cgColor
        newView.layer.cornerRadius = 5
        return newView
    }()
    let phoneField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.keyboardType = UIKeyboardType.phonePad
        field.placeholder = "(123) 456 - 7890"
        field.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return field
    }()
    let phoneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "og_phone_icon")
        return imageView
    }()
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This will update your existing phone number."
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    
    /* UIViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addComponentsToView()
        self.setComponentAnchors()
        // Create right bar button items
        self.navigationItem.title = "Phone Number"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePhoneNumber))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.phoneField.becomeFirstResponder()
        self.phoneField.addTarget(self, action: #selector(phoneNumberChanging(_:)), for: .editingChanged)
        self.setPhoneNumber()
    }
    
    /* Add UIComponents to view */
    func addComponentsToView() {
        self.view.addSubview(self.phoneView)
        self.phoneView.addSubview(self.phoneImage)
        self.phoneView.addSubview(self.phoneField)
        self.view.addSubview(self.label1)
        self.view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    /* Set UIComponent Anchors */
    func setComponentAnchors() {
        // Set CardView Anchors
        self.phoneView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height*(1/4)).isActive = true
        self.phoneView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.phoneView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.phoneView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Set CardImage Anchors
        self.phoneImage.centerYAnchor.constraint(lessThanOrEqualTo: self.phoneView.centerYAnchor).isActive = true
        self.phoneImage.leftAnchor.constraint(equalTo: self.phoneView.leftAnchor, constant: 15).isActive = true
        self.phoneImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.phoneImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        // Set CardField Anchors
        self.phoneField.leftAnchor.constraint(equalTo: self.phoneImage.rightAnchor, constant: 15).isActive = true
        self.phoneField.rightAnchor.constraint(equalTo: self.phoneView.rightAnchor, constant: 15).isActive = true
        self.phoneField.centerYAnchor.constraint(equalTo: self.phoneView.centerYAnchor).isActive = true
        self.phoneField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Set Label1 Anchors
        self.label1.topAnchor.constraint(equalTo: self.phoneView.bottomAnchor, constant: 20).isActive = true
        self.label1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.label1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.label1.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
