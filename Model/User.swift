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
    init(dictionary: [String: AnyObject]) {
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
        self.firstName = dictionary["firstName"] as? String
        self.lastName = dictionary["lastName"] as? String
        self.id = dictionary["id"] as? String
    }
}
