//
//  NewMessageController+handlers.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/7/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

extension NewMessageController {
    /* User Clicked on right bar button item */
    @objc func handleRightBarButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /* Handler for when user wants to send message */
    @objc func handleSend() {
//        self.sendMessage()
        self.dismiss(animated: true, completion: nil)
    }
    
    /* Called when keyboard is displayed */
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        self.containerViewBottomAnchor?.constant = -keyboardFrame!.height
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    /* Called when keyboard is dismissed */
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        self.containerViewBottomAnchor?.constant = 0
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

