//
//  NotificationCell.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/26/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "feed_profile_user")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Heriberto Prieto"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 14)
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, green: 228, blue: 232)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationLabel: NSMutableString = {
        let mutableString = NSMutableString()
        return mutableString
    }()
    
    let timestamp: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.rgb(155, green: 161, blue: 171)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likeButton = FeedCell.buttonForTitle("Like", imageName: "like")
    let commentButton: UIButton = FeedCell.buttonForTitle("Comment", imageName: "comment")
    let shareButton: UIButton = FeedCell.buttonForTitle("Share", imageName: "share")
    
    static func buttonForTitle(_ title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.rgb(143, green: 150, blue: 163), for: UIControlState())
        button.setImage(UIImage(named: imageName), for: UIControlState())
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
    var alert: Alert? {
        didSet {
            if let firstName = alert?.firstName, let lastName = alert?.lastName {
                print("FirstName: \(firstName)")
                print("LastName : \(lastName)")
                let attributedText = NSMutableAttributedString(string: "\(firstName) \(lastName)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
                
                if let city = alert?.location?.city, let state = alert?.location?.state {
                    print("City : \(city)")
                    print("State: \(state)")
                    attributedText.append(NSAttributedString(string: "\n\(city), \(state)  •  ", attributes: [NSAttributedStringKey.font:
                        UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor:
                            UIColor.rgb(155, green: 161, blue: 161)]))
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    
                    attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.underestimatedCount))
                    
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: "globe_small")
                    attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                    attributedText.append(NSAttributedString(attachment: attachment))
                }
                self.usernameLabel.attributedText = attributedText
            }
            
            if let timestamp = alert?.timestamp {
                self.timestamp.text = "· \(timestamp)"
            }
            
            if let statusText = alert?.statusText {
                self.statusTextView.text = statusText
            }
            
            if let profileImageName = alert?.profileImageName {
                self.profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let statusImageName = alert?.statusImageName {
                self.statusImageView.image = UIImage(named: statusImageName)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setViews()
    }
    
    func setViews() {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.addSubview(self.profileImageView)
        self.addSubview(self.usernameLabel)
        self.addSubview(self.statusTextView)
        self.addSubview(self.timestamp)
        self.addSubview(self.commentButton)
        self.addSubview(self.dividerLineView)
        // Profile Image Margins
        self.profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // Username Label Margins
        self.usernameLabel.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 10).isActive = true
        self.usernameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        self.usernameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        
        // Timestamp Label Margins
        self.timestamp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.timestamp.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        
        // Status TextView Margins
        self.statusTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 59).isActive = true
        self.statusTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.statusTextView.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: -3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}