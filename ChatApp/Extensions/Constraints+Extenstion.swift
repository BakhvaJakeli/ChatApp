//
//  Constraints+Extenstion.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

// Didn't need it after changing code, but will still leave it, as it might be usefull later.
extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
