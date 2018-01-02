//
//  Post.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/14/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class Post: SafeJsonObject {
    var currentUser: String?
    var threadId: String?
    var fromId: String?
    var firstName: String?
    var lastName: String?
    var profileImageName: String?
    var post: String?
    var numLikes: NSNumber?
    var numComments: NSNumber?
    var timestamp: Double?
    
    var location: Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}
