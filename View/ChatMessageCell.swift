//
//  ChatMessageCell.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {
    /* Cell Components */
    let textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    static let blueColor = UIColor(r: 0, g: 137, b: 249)
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dummy_image1.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let leftBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /* Cell Component Anchors */
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    func initViews() {
        // Add components to view
        self.addSubview(self.bubbleView)
        self.addSubview(self.textView)
        self.addSubview(self.profileImageView)
        self.addSubview(self.leftBorderView)
        
        // ProfileView Constraints
        self.profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // BubbleView Constraints
        self.bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.bubbleWidthAnchor = self.bubbleView.widthAnchor.constraint(equalToConstant: 180)
        self.bubbleWidthAnchor?.isActive = true
        self.bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // TextView Constraints
        self.textView.leftAnchor.constraint(equalTo: self.bubbleView.leftAnchor, constant: 10).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.textView.rightAnchor.constraint(equalTo: self.bubbleView.rightAnchor).isActive = true
        self.textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // BorderView Contraints
        self.leftBorderView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.leftBorderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.leftBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.leftBorderView.widthAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    /* Cell Class Initializer methods */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
