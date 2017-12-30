//
//  ChatThread.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/29/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class ChatThread: NSObject {
    var id: String?
    var firstName: String?
    var lastName: String?
    var profileImageUrl: String?
    var threadId: String?
    init(dictionary: [String:String]) {
        self.id = dictionary["id"]
        self.threadId = dictionary["thread_id"]
        self.lastName = dictionary["last_name"]
        self.firstName = dictionary["first_name"]
        self.profileImageUrl = dictionary["image_url"]
    }
}
