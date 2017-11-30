//
//  ContactsTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/22/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.

import UIKit

class ContactsTableViewController: UITableViewController {
    let CELLID = "contacts_cell"
    let NAMES = [
        "Heriberto","Nancy","Karina","Jessica","Leonor","Pedro"
    ]
    let HEADERS = [
        "A","B","C","D","E",
        "F","G","H","I","J",
        "K","L","M","N","O",
        "P","Q","R","S","T",
        "U","V","W","X","Y",
        "Z"
    ]
    /* ContactsTableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
    }
    /* Initialize TableView */
    func initializeTableView() {
        // TableView Settings
        self.tableView.register(ContactsCell.self, forCellReuseIdentifier: self.CELLID)
        // NavigationBar Settings
        self.navigationItem.title = "Contacts"
    }
    /* Set Number of Rows in each TableView Section */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NAMES.count
    }
    /* Set Number of Sections in TableView */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    /* Set contents of headers */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.separatorInset.left = 15
        let button = UIButton()
        button.setTitle(self.HEADERS[section], for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 15
        return button
    }
    /* Set Height for Headers */
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    /* Set Height for Rows */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    /* Cell Reusability */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath)
//        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
//        cell.textLabel?.text = self.NAMES[indexPath.row]
//        cell.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 16)
//        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
}
