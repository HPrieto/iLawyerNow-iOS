//
//  FeedCell+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 1/5/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension FeedCell {
    func likePost() {
        print("Post Liked.")
        guard let uid = Auth.auth().currentUser?.uid,
            let timestamp = self.post?.timestamp,
            let postId = self.post?.threadId else {
                return
        }
        Database.database().reference().child("messages").child(postId).child("likes").child(uid).setValue(timestamp) { (error, ref) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            self.likeView.setBackgroundImage(UIImage(named: "comment_liked"), for: .normal)
            self.post?.userLiked = true
        }
    }
    
    func unlikePost() {
        print("Post Unliked.")
        guard let uid = Auth.auth().currentUser?.uid,
        let timestamp = self.post?.timestamp,
            let postId = self.post?.threadId else {
                return
        }
        Database.database().reference().child("messages").child(postId).child("likes").child(uid).removeValue { (error, ref) in
            if error != nil {
                return
            }
            self.likeView.setBackgroundImage(UIImage(named: "heart_icon"), for: .normal)
            self.post?.userLiked = false
        }
    }
}
