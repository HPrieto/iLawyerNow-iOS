//
//  NotificationsController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/26/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class NotificationsController: UITableViewController {
    
    let CELLID = "cellId"
    var alerts = [Alert]()
    var alertsDictionary = [String:Alert]()
    var timer: Timer?
    
    let loadingView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.MainColors.lightGrey
        activityIndicator.alpha = 0
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    /* Initialize LoadingView and ActivityIndicator */
    func initializeLoadingView() {
        self.view.addSubview(self.loadingView)
        self.loadingView.addSubview(self.activityIndicator)
        
        // Loading View Constraints
        self.loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Activity Indicator Constraints
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor).isActive = true
        self.activityIndicator.topAnchor.constraint(equalTo: self.loadingView.topAnchor, constant: self.view.bounds.height*(2/3))
        self.activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func showLoadingView() {
        self.loadingView.alpha = 1.0
        self.activityIndicator.alpha = 1.0
    }
    
    func hideLoadingView() {
        self.loadingView.alpha = 0.0
        self.activityIndicator.alpha = 0.0
    }
    
    /* Controller LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeViews()
        self.initializeLoadingView()
        self.showLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.userIsLoggedIn() {
            self.observeNotifications()
        }
    }
    
    func initializeViews() {
        self.tableView.register(NotificationCell.self, forCellReuseIdentifier: self.CELLID)
        self.navigationItem.title = "Notifications"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 172, b: 237)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let alert = self.alerts[indexPath.row].post {
            let statusTextHeight = self.getTextHeight(text: alert, font: 16)
            let knownHeight: CGFloat = 55
            return CGSize(width: view.frame.width, height: statusTextHeight + knownHeight).height
        }
        return CGSize(width: view.frame.width, height: 500).height
    }
    
    func getTextHeight(text: String, font: CGFloat) -> CGFloat {
        return NSString(string: text).boundingRect(with: CGSize(width: view.frame.width-70, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).height
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alerts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        var newThread = [String:String]()
        newThread["first_name"] = self.alerts[indexPath.row].firstName
        newThread["last_name"] = self.alerts[indexPath.row].lastName
        newThread["id"] = self.alerts[indexPath.row].fromId
        newThread["thread_id"] = self.alerts[indexPath.row].threadId
        let chatThread = ChatThread(dictionary: newThread)
        chatLogController.chatThread = chatThread
        self.navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    /* TableRow Cell View */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath) as! NotificationCell
        cell.alert = self.alerts[indexPath.row]
        return cell
    }
}
