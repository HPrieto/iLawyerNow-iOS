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
    var timestamp: Double?
    var name: String?
    
    init(dictionary: [String:Any]) {
        self.name = dictionary["name"] as? String
        self.post = dictionary["post"] as? String
        self.fromId = dictionary["from_id"] as? String
        self.timestamp = dictionary["timestamp"] as? Double
    }
}
