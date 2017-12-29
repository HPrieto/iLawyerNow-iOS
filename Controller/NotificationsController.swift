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
    
    /* Controller LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeViews()
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
        if let alert = self.alerts[indexPath.item].post {
            let alertTextHeight = self.getTextHeight(text: alert, font: 16)
            let knownHeight: CGFloat = 15 + 60
            return CGSize(width: view.frame.width, height: alertTextHeight + knownHeight).height
        }
        return CGSize(width: view.frame.width, height: 500).height
    }
    
    func getTextHeight(text: String, font: CGFloat) -> CGFloat {
        return NSString(string: text).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).height
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alerts.count
    }
    
    /* TableRow Cell View */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath) as! NotificationCell
        cell.alert = self.alerts[indexPath.row]
        return cell
    }
}
