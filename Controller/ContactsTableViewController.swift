//
//  ContactsTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/22/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.

import UIKit

class ContactsTableViewController: UITableViewController {
    let CELLID = "contacts_cell"
    var contacts = [Contact]()
    var groupedContacts = [[Contact]]()
    
    /* ContactsTableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isLoggedIn() {
            self.getContacts()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        if self.groupedContacts.count > 0 {
            return self.groupedContacts[section].count
        }
        return self.contacts.count
    }
    /* Set Number of Sections in TableView */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.groupedContacts.count > 0 ? self.groupedContacts.count : 1
    }
    /* Set contents of headers */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.separatorInset.left = 15
        let button = UIButton()
        button.setTitle("\(String(describing: self.groupedContacts[section].first?.firstName?.first))", for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 15
        return button
    }
    /* Set Height for Headers */
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.groupedContacts.count == 0 ? 0 : 30
    }
    /* Set Height for Rows */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    /* Cell Reusability */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELLID, for: indexPath) as? ContactsCell
        let contact = self.contacts[indexPath.row]
        cell?.nameLabel.text = "\(contact.firstName) \(contact.lastName)"
        if let imageUrl = contact.imageUrl {
            cell?.imageView?.loadImageUsingCacheWithUrlString(urlString: imageUrl)
        }
        return cell!
    }
}
