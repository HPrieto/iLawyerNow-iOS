//
//  FeedTableViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension FeedTableViewController {
    /* Handle user login status */
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    func userIsLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    func checkForNewUserTable() {
        if let uid = Auth.auth().currentUser?.uid {
            if let usersTable = self.userTable {
                if usersTable != uid {
                    self.userTable = uid
                    self.clearTable()
                }
            } else {
                self.userTable = uid
                self.clearTable()
            }
        }
    }
    
    func clearTable() {
        print("Clearing table")
        self.usersContacts.removeAll()
        self.posts.removeAll()
        self.postsDictionary.removeAll()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func observePosts() {
        if self.userTable != Auth.auth().currentUser?.uid {
            print("Reloading a new table.")
            self.posts.removeAll()
            self.postsDictionary.removeAll()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        let newMessageRef = Database.database().reference().child("messages")
        newMessageRef.observe(.childAdded) { (snapshot) in
            guard let messageData = snapshot.value as? [String:Any] else {
                return
            }
            DispatchQueue.main.async {
                self.setUserPosts(mid: snapshot.key, messageData: messageData)
            }
        }
    }
    
    func setUserPosts(mid: String, messageData: [String:Any]) {
        guard let fromId = messageData["from_id"] as? String else {
            print("No user identified for message")
            return
        }
        Database.database().reference().child("users").child(fromId).observeSingleEvent(of: .value) { (snapshot) in
            guard var userInfo = snapshot.value as? [String:Any] else {
                return
            }
            userInfo["id"] = fromId
            let user = User(dictionary: userInfo)
            self.usersDictionary[fromId] = user
            self.setMessage(mid: mid, messageData: messageData, user: user)
        }
    }
    
    func setMessage(mid: String, messageData: [String:Any], user: User) {
        if let userId = Auth.auth().currentUser?.uid,
        let fromId = messageData["from_id"] as? String,
        let timestamp = messageData["timestamp"] as? Double,
        let post = messageData["post"] as? String {
            
            // Create new post object
            let newPost = Post()
            newPost.threadId = mid
            newPost.currentUser = user.id
            newPost.fromId = fromId
            newPost.post = post
            newPost.timestamp = timestamp
            newPost.firstName = user.firstName
            newPost.lastName = user.lastName
            
            // Profile image if available
            if let profileImageName = user.profileImageUrl {
                newPost.profileImageName = profileImageName
            }
            
            // Check how many and who liked the post
            newPost.userLiked = false
            if let likes = messageData["likes"] as? [String:Any] {
                newPost.numLikes = likes.count
                if likes[userId] != nil {
                    newPost.userLiked = true
                } else {
                    newPost.userLiked = false
                }
            } else {
                newPost.numLikes = 0
            }
            
            // Check how many comments are on this thread
            if let comments = messageData["thread"] as? [String:Any] {
                newPost.numComments = comments.count
            }
            
            // Check if this fromUser is in user's contacts list.
            if self.usersContacts[fromId] != nil {
                newPost.isContact = true
            } else {
                newPost.isContact = false
            }
            
            if self.postsDictionary[mid] != nil {
                self.postsDictionary[mid] = newPost
                self.posts[self.getPostIndex(mid)] = newPost
            } else {
                self.postsDictionary[mid] = newPost
                self.posts.append(newPost)
            }
            self.attemptReloadOfTable()
        }
    }
    
    func getPostIndex(_ mid: String) -> Int {
        for index in 0...self.posts.count {
            if self.posts[index].threadId == mid {
                return index
            }
        }
        return -1
    }
    
    fileprivate func attemptReloadOfTable() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    func setProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            self.profileImageView.image = nil
            return
        }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {
                self.profileImageView.image = nil
                return
            }
            if let imageURL = dictionary["image_url"] as? String {
                self.profileImageView.loadImageUsingCacheWithUrlString(urlString: imageURL)
            } else {
                self.profileImageView.image = nil
            }
            if let usersTable = self.userTable {
                if uid != usersTable {
                    self.clearTable()
                    self.userTable = uid
                }
            }
            if let usersContacts = dictionary["contacts"] as? [String:String] {
                for (contactId, owner) in usersContacts {
                    self.usersContacts[contactId] = owner as String
                }
            }
        }, withCancel: nil)
    }
}
