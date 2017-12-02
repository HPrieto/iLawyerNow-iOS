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
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    /* ProfileTableViewController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set NavigationBarButton Items
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.addPhotoButton.isEnabled = true
        self.addPhotoButton.isUserInteractionEnabled = true
        self.addPhotoButton.addTarget(self, action: #selector(handleAddPhotoButtonClick), for: .touchUpInside)
        self.getUserProfile()
        self.addTextFieldHandlers()
    }
    /* Sets the selector handlers for uitextfields */
    func addTextFieldHandlers() {
        self.streetAddressField.addTarget(self, action: #selector(handleStreet), for: .editingChanged)
        self.cityField.addTarget(self, action: #selector(handleCity), for: .editingChanged)
        self.stateField.addTarget(self, action: #selector(handleState), for: .editingChanged)
        self.zipCodeField.addTarget(self, action: #selector(handleZip), for: .editingChanged)
    }
    /* Saves updated address to database */
    func updateUserProfile() {
        guard let user = FIRAuth.auth()?.currentUser else {
            return
        }
        print("Street: \(self.streetAddressField.text)")
        print("City  : \(self.cityField.text)")
        print("State : \(self.stateField.text)")
        print("Zip   : \(self.zipCodeField.text)")
    }
    func getUserProfile() {
        if let user = FIRAuth.auth()?.currentUser {
            self.emailLabel.text = user.email
            FIRDatabase.database().reference().child("Users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String:Any] {
                    let firstName = dictionary["firstName"] as! String
                    let lastName  = dictionary["lastName"] as! String
                    self.fullNameLabel.text = "\(firstName) \(lastName)"
                    if let street = dictionary["street"] as? String {
                        self.streetAddressField.text = street
                    }
                    if let city = dictionary["city"] as? String {
                        self.cityField.text = city
                    }
                    if let state = dictionary["state"] as? String {
                        self.stateField.text = state
                    }
                    if let zip = dictionary["zip"] as? String {
                        self.zipCodeField.text = zip
                    }
                }
            })
        } else {
            
        }
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
