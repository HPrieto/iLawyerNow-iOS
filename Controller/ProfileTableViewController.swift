//
//  ProfileTableViewController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/17/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {
    /* UI Components */
    @IBOutlet weak var addPhotoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    var selectedImageFromPicker: UIImage?
    /* ProfileTableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set NavigationBarButton Items
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.addPhotoImageView.layer.masksToBounds = true
        self.addPhotoImageView.layer.cornerRadius = self.addPhotoImageView.bounds.width / 2
        self.addPhotoImageView.isUserInteractionEnabled = true
        self.addPhotoImageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleAddPhotoButtonClick))
        addPhotoImageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.getUserProfile()
        self.addTextFieldHandlers()
    }
    /* Sets the selector handlers for uitextfields */
    func addTextFieldHandlers() {
        self.streetAddressField.addTarget(self, action: #selector(handleFields), for: .editingChanged)
        self.cityField.addTarget(self, action: #selector(handleFields), for: .editingChanged)
        self.stateField.addTarget(self, action: #selector(handleFields), for: .editingChanged)
        self.zipCodeField.addTarget(self, action: #selector(handleFields), for: .editingChanged)
    }
    /* Saves updated address to database */
    func updateUserProfile() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileTableViewController viewWillAppear")
        let topOffset = CGPoint(x: 0, y: self.tableView.contentInset.top)
        self.tableView.setContentOffset(topOffset, animated: false)
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
