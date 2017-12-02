//
//  FeedTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/23/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

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
                if let dictionary = snapshot.value as? [String:Any] {
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
        return 10
    }
    /* TableRow Heights */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    /* User tapped on tableview cell */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    /* TableRow Cell View */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath)
        return cell
    }
}

/* UIColor extension */
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
