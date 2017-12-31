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
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var borderViewLeftAnchor: NSLayoutConstraint?
    var borderViewRightAnchor: NSLayoutConstraint?
    func initViews() {
        // Add components to view
        self.addSubview(self.textView)
        self.addSubview(self.bubbleView)
        self.addSubview(self.borderView)
        self.addSubview(self.profileImageView)
        // ProfileView Constraints
        self.profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        // BubbleView Constraints
        self.bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // TextView Constraints
        self.textView.leftAnchor.constraint(equalTo: self.bubbleView.leftAnchor, constant: 10).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.textView.rightAnchor.constraint(equalTo: self.bubbleView.rightAnchor, constant: -20).isActive = true
        self.textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        // BorderView Contraints
        self.borderViewLeftAnchor = self.borderView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5)
        self.borderViewRightAnchor = self.borderView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        self.borderViewLeftAnchor?.isActive = true
        self.borderView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.borderView.widthAnchor.constraint(equalToConstant: 3).isActive = true
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
