//
//  ChatLogController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

extension ChatLogController {
    /* Handler for when user wants to send message */
    @objc func handleSend() {
        self.sendMessage()
    }
    
    @objc func handleReloadTable() {
        self.messages = Array(self.messagesDictionary.values)
        self.messages.sort(by: { (message1, message2) -> Bool in
            return message1.timestamp < message2.timestamp
        })
        DispatchQueue.main.async(execute: {
            self.collectionView?.reloadData()
            if self.inputTextField.isFirstResponder {
                self.scrollCollectionViewTo(position: .bottom, animated: true)
            }
        })
    }
    
    /* Called when keyboard is displayed */
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        //let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        }) { (true) in
            self.scrollCollectionViewTo(position: .bottom, animated: true)
        }
    }
    
    /* Called when keyboard is dismissed */
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
