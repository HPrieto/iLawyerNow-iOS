//
//  ChatLogController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase
class ChatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var messages = [Message]()
    var messagesDictionary = [String:Message]()
    var timer: Timer?
    
    var chatThread: ChatThread? {
        didSet {
            if let firstName = chatThread?.firstName, let lastName = chatThread?.lastName {
                self.navigationItem.title = "\(firstName) \(lastName)"
            }
        }
    }
    
    /* ChatLog Controller Components */
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var inputContainerView: UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        containerView.backgroundColor = UIColor.white
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: UIControlState())
        sendButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        sendButton.setTitleColor(UIColor.white, for: .normal)
        sendButton.backgroundColor = UIColor.MainColors.lightColor
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        containerView.addSubview(self.inputTextField)
        
        self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return containerView
    }()
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    let loadingView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.MainColors.lightGrey
        activityIndicator.alpha = 0
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    func showLoadingView() {
        self.loadingView.alpha = 1.0
        self.activityIndicator.alpha = 1.0
    }
    
    func hideLoadingView() {
        self.loadingView.alpha = 0.0
        self.activityIndicator.alpha = 0.0
    }
    
    /* Controller LifeCycle */
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ChatLog ViewDidLoad")
        self.collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: self.cellId)
        self.collectionView?.keyboardDismissMode = .interactive
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(handleRightBarButtonClick))
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.MainColors.lightColor
        self.showLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ChatLog ViewWillAppear")
        if self.userIsLoggedIn() {
            self.setUserPostToThread()
            self.observeThread()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ChatLog ViewDidAppear")
        self.setupKeyboardObservers()
        self.inputTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ChatLog ViewWillDisappear")
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /* Initialize LoadingView and ActivityIndicator */
    func initializeLoadingView() {
        self.view.addSubview(self.loadingView)
        self.loadingView.addSubview(self.activityIndicator)
        
        // Loading View Constraints
        self.loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Activity Indicator Constraints
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor).isActive = true
        self.activityIndicator.topAnchor.constraint(equalTo: self.loadingView.topAnchor, constant: self.view.bounds.height*(2/3))
        self.activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /* CollectionView Override Methods */
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let message = self.messages[indexPath.item].post {
            let statusTextHeight = self.getTextHeight(text: message, font: 16)
            let knownHeight: CGFloat = 20
            return CGSize(width: view.frame.width, height: statusTextHeight + knownHeight)
        }
        return CGSize(width: view.frame.width, height: 500)
    }
    
    /* Returns the height of given string with given font */
    func getTextHeight(text: String, font: CGFloat) -> CGFloat {
        return NSString(string: text).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).height
    }
    
    /* Set cell at indexPath */
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ChatMessageCell
        let message = self.messages[indexPath.item]
        cell.textView.text = message.post
        setupCell(cell, message: message)
        return cell
    }
    
    /* Checks if message is from current user or someone else. */
    fileprivate func setupCell(_ cell: ChatMessageCell, message: Message) {
        if let profileImageUrl = self.chatThread?.profileImageUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        if message.fromId == self.userId() {
            cell.nameLabel.text = "ME"
            cell.nameLabel.textAlignment = .right
            cell.nameLabel.textColor = UIColor.MainColors.lightColor
            cell.textView.textAlignment = .right
            cell.borderViewRightAnchor?.isActive = true
            cell.borderViewLeftAnchor?.isActive = false
            cell.borderView.backgroundColor = UIColor.MainColors.lightColor
            cell.textView.textColor = UIColor.black
            cell.profileImageView.isHidden = true
        } else {
            cell.nameLabel.text = message.name
            cell.nameLabel.textAlignment = .left
            cell.nameLabel.textColor = UIColor.red
            cell.textView.textAlignment = .left
            cell.borderViewRightAnchor?.isActive = false
            cell.borderViewLeftAnchor?.isActive = true
            cell.borderView.backgroundColor = UIColor.red
            cell.profileImageView.isHidden = false
        }
    }
    
    func scrollCollectionViewTo(position:UICollectionViewScrollPosition, animated:Bool) {
        let collectionIndexPath:NSIndexPath = NSIndexPath.init(row: self.messages.count-1, section: 0)
        self.collectionView?.scrollToItem(at: collectionIndexPath as IndexPath, at: position, animated: animated)
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
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
