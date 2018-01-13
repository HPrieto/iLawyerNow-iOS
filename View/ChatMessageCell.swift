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
        imageView.image = UIImage(named: "feed_profile_user")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func initViews() {
        // Add components to view
        self.addSubview(self.textView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.bubbleView)
        self.addSubview(self.rightBorderView)
        
        if self.profileImageView.isHidden == true {
            self.textView.leftAnchor.constraint(equalTo: self.bubbleView.leftAnchor, constant: 10).isActive = true
        } else {
            // ProfileView Constraints
            self.addSubview(self.profileImageView)
            self.profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
            self.profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
            self.profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            // Left BorderView Contraints
            self.addSubview(self.leftBorderView)
            self.leftBorderView.widthAnchor.constraint(equalToConstant: 3).isActive = true
            self.leftBorderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.leftBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.leftBorderView.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 10).isActive = true
            
            self.textView.leftAnchor.constraint(equalTo: self.leftBorderView.rightAnchor, constant: 10).isActive = true
        }
        
        // BubbleView Constraints
        self.bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // TextView Constraints
        self.textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.textView.rightAnchor.constraint(equalTo: self.bubbleView.rightAnchor, constant: -20).isActive = true
        self.textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // Right BorderView Contraints
        self.rightBorderView.widthAnchor.constraint(equalToConstant: 3).isActive = true
        self.rightBorderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.rightBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.rightBorderView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        // NameLabel Constraints
        self.nameLabel.leftAnchor.constraint(equalTo: self.textView.leftAnchor, constant: 5).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.textView.rightAnchor, constant: -5).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
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
