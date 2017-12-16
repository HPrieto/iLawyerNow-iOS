//
//  SafeJsonObject.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 12/14/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        let selectorString = "set\(key.uppercased().characters.first!)\(String(key.characters.dropFirst()))"
        let selector = Selector(selectorString)
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
}
