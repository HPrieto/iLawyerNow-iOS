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
    var posts = [Post]()
    
    let images = ["dummy_image0.jpeg",
                  "dummy_image1.jpeg",
                  "dummy_image2.jpeg",
                  "dummy_image3.jpeg",
                  "dummy_image4.jpeg"]
    let status = ["For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.","For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.","For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.","For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine.","For Ten hat aficionados, in appreciation for their exquisite taste in millinery, will be picked at random to tour the LA tunnel & drive boring machine."]
    
    /* TableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initFeed()
        self.checkIfUserIsLoggedIn()
        
        for index in 0..<images.count {
            let post = Post()
            let location = Location()
            location.city = "Fontana"
            location.state = "CA"
            post.firstName = "Heriberto"
            post.lastName = "Prieto"
            post.profileImageName = self.images[index]
            post.timestamp = "\(index)h"
            post.statusText = self.status[index]
            post.location = location
            self.posts.append(post)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /* Init TableViewController */
    let greyBubbleColor = UIColor(r: 19, g: 136, b: 143)
    func initFeed() {
        self.tableView.register(FeedCell.self, forCellReuseIdentifier: self.CELLID)
        self.navigationItem.title = "Home"
        self.navigationItem.rightBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeMessage))
        self.navigationItem.rightBarButtonItem?.tintColor = self.greyBubbleColor
    }
    
    /* Number of Rows in section */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    /* TableRow Heights */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let statusText = posts[indexPath.item].statusText {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], context: nil)
            
            let knownHeight: CGFloat = 15 + 44 + 50
            print("Custom Height")
            return CGSize(width: view.frame.width, height: rect.height + knownHeight).height
        }
        return CGSize(width: view.frame.width, height: 500).height
    }
    
    /* User tapped on tableview cell */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    /* TableRow Cell View */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath) as! FeedCell
        cell.post = self.posts[indexPath.row]
        return cell
    }
}
