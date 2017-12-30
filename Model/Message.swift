//
//  Message.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    var fromId: String?
    var post: String?
    var timestamp: NSNumber?
    
    init(dictionary: [String:Any]) {
        self.fromId = dictionary["from_id"] as? String
        self.post = dictionary["post"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
    }
}
