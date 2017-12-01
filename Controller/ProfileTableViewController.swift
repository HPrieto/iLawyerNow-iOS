//
//  ProfileTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/17/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    /* UI Components */
    @IBOutlet weak var addPhotoButton: UIButton!
    /* ProfileTableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set NavigationBarButton Items
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        self.addPhotoButton.isEnabled = true
        self.addPhotoButton.isUserInteractionEnabled = true
        self.addPhotoButton.addTarget(self, action: #selector(handleAddPhotoButtonClick), for: .touchUpInside)
    }
    @objc func handleAddPhotoButtonClick() {
        print("Adding photo...")
        self.view.endEditing(true)
    }
    @objc func rightBarButtonItemClicked() {
        print("Next Button Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileTableViewController viewWillAppear")
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileTableViewController viewWillAppear")
    }
    /* Sets the height for header */
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0.01
        } else {
            return 30.0
        }
    }
    /* Rounds UIButton's corners */
    func roundButtonCorners(button:UIButton) {
        let buttonMaskPath = UIBezierPath(roundedRect: button.bounds,
                                          byRoundingCorners: [.topRight,.topLeft,.bottomRight,.bottomLeft],
                                          cornerRadii: CGSize(width: button.bounds.width/3,
                                                              height: button.bounds.height/3))
        let shape         = CAShapeLayer()
        shape.path        = buttonMaskPath.cgPath
        button.layer.mask = shape
    }
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.view.endEditing(true)
    }
}
