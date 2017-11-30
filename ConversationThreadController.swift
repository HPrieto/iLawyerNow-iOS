//
//  ConversationThreadController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/25/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class ConversationThreadController: UIViewController {
    /* UIComponents */
    let messageView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let messageField: UITextField = {
        let textfield = UITextField()
        textfield.layer.backgroundColor = UIColor.white.cgColor
        textfield.font = UIFont(name: "AvenirNext-Medium", size: 18)
        textfield.textColor = UIColor.lightGray
        textfield.placeholder = "Write your message..."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    /* Controller Life Cycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 19/255, green: 136/255, blue: 143/255, alpha: 1.0)
        // TextField Observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageField.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    /* Initialize View Components */
    func initializeView() {
        self.view.addSubview(messageView)
        messageView.addSubview(messageField)
        messageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        messageField.leftAnchor.constraint(equalTo: messageView.leftAnchor, constant: 15).isActive = true
        messageField.rightAnchor.constraint(equalTo: messageView.rightAnchor, constant: 15).isActive = true
        messageField.topAnchor.constraint(equalTo: messageView.topAnchor).isActive = true
    }
    /* Keyboard Observers */
    @objc func keyboardWillHide(notification: NSNotification) {
        messageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            messageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardSize.height).isActive = true
        }
    }
}
