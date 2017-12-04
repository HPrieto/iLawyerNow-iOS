//
//  FeedTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/23/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

let dummyData = ["Leonor","Pedro","Heriberto","Karina","Jessica"]
let dummyComment = ["I just got into an accident, what can I do?",
                    "My son was just arrested for posession, what can I do?",
                    "My husband beat me, what can I do?",
                    "Can I go to jail for driving under the influence?",
                    "My babydaddy is not paying his childsupport, what can I do?"]
let dummy_images = ["dummy_image0","dummy_image1","dummy_image2","dummy_image3","dummy_image4"]
class FeedTableViewController: UITableViewController {
    /* Global Variables */
    var CELLID = "cellId"
    /* TableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initFeed()
        self.checkIfUserIsLoggedIn()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    /* Handle user login status */
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject] {
                    guard let firstName = dictionary["firstName"] as? String else {
                        return
                    }
                    self.navigationItem.title = "\(firstName)'s feed"
                }
            })
        }
    }
    @objc func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        self.navigationController?.pushViewController(LoginSignupController(), animated: false)
    }
    
    /* Init TableViewController */
    func initFeed() {
        self.tableView.register(FeedCell.self, forCellReuseIdentifier: self.CELLID)
        self.navigationItem.title = "Home"
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeMessage))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(r: 19, g: 136, b: 143)
    }
    
    /* Create a new messaging thread */
    @objc func composeMessage() {
        let newMessageController = UINavigationController(rootViewController: NewMessageController())
        present(newMessageController, animated: true, completion: nil)
    }
    
    /* Number of Rows in section */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    /* TableRow Heights */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    /* User tapped on tableview cell */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(chatLogController, animated: true)
    }
    /* TableRow Cell View */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath) as! FeedCell
        cell.profileImageView.image = UIImage(named: "\(dummy_images[indexPath.row]).jpeg")
        cell.usernameLabel.text = dummyData[indexPath.row]
        cell.postTextView.text = dummyComment[indexPath.row]
        return cell
    }
}
