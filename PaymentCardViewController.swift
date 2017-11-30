//
//  PaymentCardViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/19/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class PaymentCardViewController: UIViewController {
    /* Global Constants */
    let CREDITCARDREGEX = "^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})$"
    /* UIComponents */
    let cardView: UIView = {
        let newView = UIView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.backgroundColor = UIColor.white
        newView.layer.borderWidth = 1
        newView.layer.borderColor = UIColor.lightGray.cgColor
        newView.layer.cornerRadius = 5
        return newView
    }()
    let cardField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.keyboardType = UIKeyboardType.numberPad
        field.placeholder = "1234 5678 1234 5678"
        field.font = UIFont(name: "AvenirNext-Regular", size: 18)
        return field
    }()
    let cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "credit_card_back_icon")
        return imageView
    }()
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This will update your existing payment card."
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This card will only be charged when you"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    let label3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "place an order."
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    /* UIComponent Listeners */
    @objc func cardNumberChanging(_ textField: UITextField) {
        if let count = textField.text?.count {
            if (count == 16) {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    /* UIViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addComponentsToView()
        self.setComponentAnchors()
        self.cardField.becomeFirstResponder()
        self.cardField.addTarget(self, action: #selector(cardNumberChanging(_:)), for: .editingChanged)
        // Create NavigationBar Button Items
        self.navigationItem.title = "Payment Card"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveCardNumber))
        self.navigationItem.leftBarButtonItem?.action = #selector(goBack)
    }
    /* Right Bar Button Item Action: Go Back once changes are done */
    @objc func saveCardNumber() {
        self.navigationController?.popViewController(animated: true)
    }
    /* Left Bar Button Item Action: Go Back */
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    /* Add UIComponents to view */
    func addComponentsToView() {
        self.view.addSubview(self.cardView)
        self.cardView.addSubview(self.cardImage)
        self.cardView.addSubview(self.cardField)
        self.view.addSubview(self.label1)
        self.view.addSubview(self.label2)
        self.view.addSubview(self.label3)
        self.view.backgroundColor = UIColor.groupTableViewBackground
    }
    /* Set UIComponent Anchors */
    func setComponentAnchors() {
        // Set CardView Anchors
        self.cardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        self.cardView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.cardView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.cardView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        // Set CardImage Anchors
        self.cardImage.centerYAnchor.constraint(lessThanOrEqualTo: self.cardView.centerYAnchor).isActive = true
        self.cardImage.leftAnchor.constraint(equalTo: self.cardView.leftAnchor, constant: 15).isActive = true
        self.cardImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.cardImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        // Set CardField Anchors
        self.cardField.leftAnchor.constraint(equalTo: self.cardImage.rightAnchor, constant: 15).isActive = true
        self.cardField.rightAnchor.constraint(equalTo: self.cardView.rightAnchor, constant: 15).isActive = true
        self.cardField.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor).isActive = true
        self.cardField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Set Label1 Anchors
        self.label1.topAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: 20).isActive = true
        self.label1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.label1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.label1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Set Label2 Anchors
        self.label2.topAnchor.constraint(equalTo: self.label1.bottomAnchor, constant: 0).isActive = true
        self.label2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.label2.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        // Set Label3 Anchors
        self.label3.topAnchor.constraint(equalTo: self.label2.bottomAnchor, constant: 0).isActive = true
        self.label3.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.label3.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
    }
}
