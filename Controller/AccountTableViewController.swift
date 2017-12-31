//
//  AccountTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/17/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

class AccountTableViewController: UITableViewController, UITabBarDelegate {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileNameImage: UIImageView!
    
    var logoutContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoutMessage: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you want to log out?"
        label.numberOfLines = 2
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(r: 240, g: 0, b: 42)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelLogoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.textColor = UIColor.lightText
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var logoutViewBottomMargin: NSLayoutConstraint?
    var logoutViewTopMargin: NSLayoutConstraint?
    func initializeLogoutView() {
        self.view.addSubview(self.logoutContainer)
        self.logoutContainer.addSubview(self.logoutView)
        self.logoutContainer.addSubview(self.logoutMessage)
        self.logoutContainer.addSubview(self.logoutButton)
        self.logoutContainer.addSubview(self.cancelLogoutButton)
        
        // Logout Container Margins
        self.logoutContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.logoutContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.logoutContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.logoutContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // LogoutView Margins
        self.logoutViewTopMargin = self.logoutView.topAnchor.constraint(equalTo: self.logoutContainer.topAnchor)
        self.logoutViewTopMargin?.isActive = true
        self.logoutViewBottomMargin = self.logoutView.bottomAnchor.constraint(equalTo: self.logoutContainer.bottomAnchor)
        
    }
    
    /* AccountTableViewController LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.MainColors.mainColor
        self.profileNameImage.layer.masksToBounds = true
        self.profileNameImage.layer.cornerRadius = self.profileNameImage.bounds.width / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AccountTableViewController viewWillAppear")
        let topOffset = CGPoint(x: 0, y: self.tableView.contentInset.top)
        self.tableView.setContentOffset(topOffset, animated: false)
        self.setUserProfileName()
        self.scrollToTop(animated: false)
    }
    /* Scrolls TableView to top */
    func scrollToTop(animated: Bool) {
        let indexPath = NSIndexPath.init(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: animated)
    }
    /* Get section being selected */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        if row == 2 && section == 1 {
            self.navigationController?.pushViewController(ContactsTableViewController(), animated: true)
        } else if row == 0 && section == 1 {
            self.navigationController?.pushViewController(PhoneViewController(), animated: true)
        } else if row == 1 && section == 1 {
            self.navigationController?.pushViewController(PaymentCardViewController(), animated: true)
        } else if row == 0 && section == 4 {
            // prompt and logout user
            self.logoutUser()
        }
        print(row, section)
    }
    
    /* UIManip */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
