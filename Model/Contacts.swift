//
//  Contacts.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 1/13/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

class Contact {
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    var whosContact: String?
    
    init(data: [String:Any]) {
        self.firstName = data["first_name"] as? String
        self.lastName = data["last_name"] as? String
        if let profileImageUrl = data["image_url"] as? String {
            self.imageUrl = profileImageUrl
        }
    }
}
