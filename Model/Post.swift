//
//  Post.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/14/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class Post: SafeJsonObject {
    var firstName: String?
    var lastName: String?
    var profileImageName: String?
    var statusText: String?
    var statusImageName: String?
    var numLikes: NSNumber?
    var numComments: NSNumber?
    var timestamp: String?
    
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
