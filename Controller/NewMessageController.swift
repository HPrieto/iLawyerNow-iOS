//
//  NewMessageController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class NewMessageController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var messages = [Message]()
    
    /* NewMessage Controller Components */
    let messageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.black
        textField.placeholder = "What's happening?"
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 21)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.MainColors.lightColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNewMessage), for: .touchUpInside)
        return button
    }()
    
    /* Controller LifeCycle */
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("NewMessage ViewDidLoad")
        self.initializeMainViews()
        self.initializeMargins()
        self.setupKeyboardObservers()
        
    }
    
    func initializeMainViews() {
        self.view.backgroundColor = UIColor.white
        self.collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: self.cellId)
        self.collectionView?.keyboardDismissMode = .interactive
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.MainColors.lightColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(handleRightBarButtonClick))
    }
    
    var sendMessageButtonBottomMargin: NSLayoutConstraint?
    func initializeMargins() {
        self.view.addSubview(self.messageTextField)
        self.view.addSubview(self.sendMessageButton)
        // TextField Margins
        self.messageTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        self.messageTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        self.messageTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        
        // SendButton Margins
        self.sendMessageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.sendMessageButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.sendMessageButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.sendMessageButtonBottomMargin = self.sendMessageButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        self.sendMessageButtonBottomMargin?.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("NewMessage ViewWillAppear")
        self.setProfileImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("NewMessage ViewDidAppear")
        self.messageTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("NewMessage ViewWillDisappear")
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
}

