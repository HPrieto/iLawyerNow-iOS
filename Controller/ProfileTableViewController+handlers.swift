//
//  ProfileTableViewController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/1/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension ProfileTableViewController {
    /* AddPhoto Button Handler */
    @objc func handleAddPhotoButtonClick() {
        print("Adding photo...")
        self.view.endEditing(true)
        let picker = UIImagePickerController()
        present(picker, animated: true, completion: nil)
    }
    /* Right NavigationButton Handler */
    @objc func rightBarButtonItemClicked() {
        print("Next Button Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    /* UITextField handlers for street, city, state, zip */
    @objc func handleStreet(textField: UITextField) {
        guard let street = self.streetAddressField.text else {
            return
        }
        if self.regexValidation(string: street, regEx: "") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    @objc func handleCity(textField: UITextField) {
        guard let city = self.cityField.text else {
            return
        }
        if self.regexValidation(string: city, regEx: "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    @objc func handleState(textField: UITextField) {
        guard let state = self.stateField.text else {
            return
        }
        if self.regexValidation(string: state, regEx: "([a-zA-Z]+|[a-zA-Z]+\\s[a-zA-Z]+)") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    @objc func handleZip(textField: UITextField) {
        guard let zip = self.zipCodeField.text else {
            return
        }
        if self.regexValidation(string: zip, regEx: "(?:(\\+\\d\\d\\s+)?((?:\\(\\d\\d\\)|\\d\\d)\\s+)?)(\\d{4,5}\\-?\\d{4})") {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    /* Not a handler but whatevs */
    func regexValidation(string: String, regEx: String) -> Bool {
        var returnValue = true
        do {
            let regex = try NSRegularExpression(pattern: regEx)
            let nsString = string as NSString
            let results = regex.matches(in: string, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
}
