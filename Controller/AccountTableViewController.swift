//
//  AccountTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/17/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

class AccountTableViewController: UITableViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileNameImage: UIImageView!
    /* AccountTableViewController LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileNameImage.layer.masksToBounds = true
        self.profileNameImage.layer.cornerRadius = self.profileNameImage.bounds.width / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AccountTableViewController viewWillAppear")
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
        self.setUserProfileName()
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
            do {
                try FIRAuth.auth()?.signOut()
            } catch let logoutError {
                print(logoutError)
            }
            self.navigationController?.pushViewController(LoginSignupController(), animated: false)
        }
        print(row, section)
    }
    /* UIManip */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
