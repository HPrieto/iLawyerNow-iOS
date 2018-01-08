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
    
    func addUserToContacts() {
        print("User added to contacts.")
        guard let uid = Auth.auth().currentUser?.uid,
            let fromId = self.post?.fromId,
            let timestamp = self.post?.timestamp else {
                return
        }
        Database.database().reference().child("users").child(uid).child("contacts").child(fromId).setValue(timestamp) { (error, ref) in
            if error != nil {
                return
            }
            self.contactView.setBackgroundImage(UIImage(named: "contacted_added"), for: .normal)
            self.post?.isContact = true
        }
    }
    
    func checkContacts() {
        guard let uid = Auth.auth().currentUser?.uid,
        let fromId = self.post?.fromId else {
            return
        }
        print("Post from: \(fromId)")
        print("My Id: \(uid)\n\n")
        if uid == fromId {
            self.contactView.alpha = 1
        } else {
            self.contactView.alpha = 0
        }
    }
}
