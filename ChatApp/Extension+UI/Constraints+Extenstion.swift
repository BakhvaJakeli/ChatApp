//
//  Constraints+Extenstion.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
