//
//  User.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class User: NSObject {
    var profileImageUrl: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var id: String?
    init(dictionary: [String: Any]) {
        self.profileImageUrl = dictionary["image_url"] as? String
        self.firstName = dictionary["first_name"] as? String
        self.lastName = dictionary["last_name"] as? String
        self.id = dictionary["id"] as? String
    }
}
