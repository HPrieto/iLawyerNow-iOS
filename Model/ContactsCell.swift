//
//  ContactsCell.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/23/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class ContactsCell: UITableViewCell {
    /* Called on dequeue */
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    /* Cell Components */
    let profileImage:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.cornerRadius = 17.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Heriberto Prieto"
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let addressLabel:UILabel = {
        let label = UILabel()
        label.text = "Fontana, CA"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    /* Add subviews and set margins */
    func setupViews() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(addressLabel)
        // Profile pic constraints
        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // Profile username constraints
        nameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        // Address label constraints
        addressLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 10).isActive = true
        addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
