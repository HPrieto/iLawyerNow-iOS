//
//  FeedCell.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/23/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    var profileImageView: UIImageView = {
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
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
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
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.accentColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    var post: Post? {
        didSet {
            if let firstName = post?.firstName, let lastName = post?.lastName {
                let attributedText = NSMutableAttributedString(string: "\(firstName) \(lastName)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
                
                if let city = post?.location?.city, let state = post?.location?.state {
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
            
            if let timestamp = post?.timestamp {
                self.timestamp.text = "\(self.getTimeLabel(timestamp: timestamp))"
            }
            
            if let statusText = post?.post {
                self.statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                self.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageName)
            }
            
            if let numLikes = post?.numLikes {
                if numLikes == 0 {
                    self.likesLabel.text = ""
                } else {
                    self.likesLabel.text = "\(numLikes)"
                }
            }
            
            if let numComments = post?.numComments {
                if numComments == 0 {
                    self.commentsLabel.text = ""
                } else {
                    self.commentsLabel.text = "\(numComments)"
                }
            }
            
            if let userLiked = post?.userLiked {
                if userLiked {
                    self.likeView.setBackgroundImage(UIImage(named: "comment_liked"), for: .normal)
                }
            }
            
        }
    }
    
    func getTimeLabel(timestamp: Double) -> String {
        let currentTime = NSDate().timeIntervalSince1970
        let seconds     = (currentTime - timestamp)
        let minutes     = Int(floor(seconds/60))
        if seconds < 60 {
            return "\(Int(seconds))s ago"
        } else {
            if minutes < 60 {
                return "\(Int(minutes))min ago"
            } else {
                let hours = minutes/60
                if hours < 24 {
                    return "\(Int(hours))hrs ago"
                } else {
                    let days = hours/24
                    if days == 1 {
                        return "\(Int(days)) day ago"
                    } else {
                        return "\(Int(days)) days ago"
                    }
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setViews()
    }
    
    func setViews() {
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.addSubview(self.profileImageView)
        self.addSubview(self.usernameLabel)
        self.addSubview(self.statusTextView)
        self.addSubview(self.timestamp)
        self.addSubview(self.commentButton)
        self.addSubview(self.dividerLineView)
        self.addSubview(self.separatorView)
        
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
        
        // Separator View
        self.separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.separatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.separatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        // Divider LineView Margins
        self.addSubview(self.actionView)
        self.actionView.addSubview(self.commentView)
        self.actionView.addSubview(self.shareView)
        self.actionView.addSubview(self.likeView)
        self.actionView.addSubview(self.contactView)
        
        let iconDimensions:CGFloat = 16.0
        self.actionView.topAnchor.constraint(equalTo: self.statusTextView.bottomAnchor, constant: -4).isActive = true
        self.actionView.leftAnchor.constraint(equalTo: self.usernameLabel.leftAnchor).isActive = true
        self.actionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.actionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        self.commentView.leftAnchor.constraint(equalTo: self.actionView.leftAnchor).isActive = true
        self.commentView.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
        self.commentView.heightAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        self.commentView.widthAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        
        self.shareView.leftAnchor.constraint(equalTo: self.actionView.leftAnchor, constant: (self.bounds.width-60)*(1/4)).isActive = true
        self.shareView.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
        self.shareView.widthAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        self.shareView.heightAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        
        self.likeView.leftAnchor.constraint(equalTo: self.actionView.leftAnchor, constant: (self.bounds.width-60)*(1/2)).isActive = true
        self.likeView.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
        self.likeView.widthAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        self.likeView.heightAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        
        self.contactView.leftAnchor.constraint(equalTo: self.actionView.leftAnchor, constant: (self.bounds.width-60)*(3/4)).isActive = true
        self.contactView.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
        self.contactView.widthAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        self.contactView.heightAnchor.constraint(equalToConstant: iconDimensions).isActive = true
        
        self.actionView.addSubview(self.commentsLabel)
        self.commentsLabel.leftAnchor.constraint(equalTo: self.commentView.rightAnchor, constant: 5).isActive = true
        self.commentsLabel.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
        
        self.actionView.addSubview(self.sharesLabel)
        self.sharesLabel.leftAnchor.constraint(equalTo: self.shareView.rightAnchor, constant: 5).isActive = true
        self.sharesLabel.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
        
        self.actionView.addSubview(self.likesLabel)
        self.likesLabel.leftAnchor.constraint(equalTo: self.likeView.rightAnchor, constant: 5).isActive = true
        self.likesLabel.centerYAnchor.constraint(equalTo: self.actionView.centerYAnchor).isActive = true
    }
    
    let actionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentView: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "bubble_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shareView: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "share_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeView: UIButton = {
        let button = UIButton()
        button.setTitleShadowColor(UIColor.MainColors.darkGrey, for: .normal)
        button.setBackgroundImage(UIImage(named: "heart_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contactView: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "message_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDirectMessage), for: .touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
