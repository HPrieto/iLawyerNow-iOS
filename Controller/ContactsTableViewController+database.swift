//
//  ContactsTableViewController+database.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 1/13/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import UIKit
import Firebase

extension ContactsTableViewController {
    
    /* Returns false if user is logged out. */
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    /* Retreives user's contacts */
    func getContacts() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Not signed in.")
            return
        }
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let userInfo = snapshot.value as? [String:Any] else {
                return
            }
            if let contactList = userInfo["contacts"] as? [String:String] {
                self.setContacts(contactList: contactList)
            }
        }
    }
    
    func setContacts(contactList: [String:String]) {
        for (contactId, owner) in contactList {
            Database.database().reference().child("users").child(contactId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let contactInfo = snapshot.value as? [String:Any] {
                    let newContact = Contact(data: contactInfo)
                    newContact.whosContact = owner
                    self.contacts.append(newContact)
                }
            })
        }
        print("Contacts: \(self.contacts.count)")
        let groupedDictionary = Dictionary(grouping: self.contacts) { (contact) -> String in
            return contact.firstName!
        }
        print("Grouped Dictionary: \(groupedDictionary)\n\n")
        let keys = groupedDictionary.keys.sorted()
        
        keys.forEach({
            self.groupedContacts.append(groupedDictionary[$0]!)
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
// Pass: neuralnetworksrock
