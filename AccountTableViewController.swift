//
//  AccountTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/17/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {
    
    /* AccountTableViewController LifeCycle Methods */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AccountTableViewController viewWillAppear")
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
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
            self.navigationController?.pushViewController(LoginSignupController(), animated: false)
        }
        print(row, section)
    }
    /* UIManip */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
