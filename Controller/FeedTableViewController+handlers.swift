//
//  FeedTableViewController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/3/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension FeedTableViewController {
    
    /* Create a new messaging thread */
    @objc func composeMessage() {
        let newMessageController = UINavigationController(rootViewController: NewMessageController())
        present(newMessageController, animated: true, completion: nil)
    }
}
