//
//  FeedCell.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/23/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "feed_profile_user")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Heriberto Prieto"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.text = "10h"
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "convo_bubble")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let thumbsupIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "thumbs_up")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let postTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Here's a wonderful book on statistical #NLP: Foundations of Statistical Natural Language Processing, available at https://nlp.stanford.edu/fsnlp/."
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont(name: "AvenirNext-Medium", size: 16)
        textView.backgroundColor = UIColor.clear
//        let lineSpace = NSMutableParagraphStyle()
//        lineSpace.lineSpacing = 1
//        let textViewAttributes = [NSAttributedStringKey.paragraphStyle: lineSpace]
//        textView.attributedText = NSAttributedString(string: textView.text, attributes: textViewAttributes)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func setCellViews() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Add component to subview
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(timestampLabel)
        addSubview(commentIcon)
        addSubview(thumbsupIcon)
        addSubview(postTextView)
        
        // Profile Image Constraints
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        // Username Label Constraints
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Timestamp Label Constraints
        timestampLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        timestampLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        timestampLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // ThumbsupIcon Constraints
        thumbsupIcon.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15).isActive = true
        thumbsupIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        thumbsupIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        thumbsupIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // CommentIcon Constraints
        commentIcon.leftAnchor.constraint(equalTo: thumbsupIcon.rightAnchor, constant: 85).isActive = true
        commentIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        commentIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        commentIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // PostTextView Constraints
        postTextView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: -5).isActive = true
        postTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        postTextView.bottomAnchor.constraint(equalTo: thumbsupIcon.topAnchor, constant: -5).isActive = true
        postTextView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 5).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setCellViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
