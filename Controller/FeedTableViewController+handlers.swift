//
//  FeedTableViewController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

extension FeedTableViewController {
    
    @objc func handleReloadTable() {
        self.posts = Array(self.postsDictionary.values)
        self.posts.sort(by: { (post1, post2) -> Bool in
            return post1.timestamp > post2.timestamp
        })
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    /* Create a new messaging thread */
    @objc func composeMessage() {
        let newMessageController = NewMessageController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationNewMessageController = UINavigationController(rootViewController: newMessageController)
        self.present(navigationNewMessageController, animated: true, completion: nil)
    }
    
    /* Pushes to LoginSignupViewController */
    @objc func handleLogout() {
        self.navigationController?.pushViewController(LoginSignupController(), animated: false)
    }
}
