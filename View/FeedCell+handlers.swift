//
//  FeedCell+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 1/5/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit

extension FeedCell {
    @objc func handleLike() {
        if let postLiked = post?.userLiked {
            if !postLiked {
                self.likePost()
            } else {
                self.unlikePost()
            }
        }
    }
    
    @objc func handleContactAdded() {
        print("Adding user to contacts.")
        self.addUserToContacts()
    }
}
