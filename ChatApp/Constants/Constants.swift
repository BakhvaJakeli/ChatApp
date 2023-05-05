//
//  Constants.swift
//  ChatApp
//
//  Created by bakhva  on 02.05.23.
//

import UIKit

// MARK: View Controller Extension
enum ChatViewControllerConstants {
    static let switcherWidth: CGFloat = 54
    static let switcherHeight: CGFloat = 27
    static let switcherTopPadding: CGFloat = 8
    static let dividerViewHeight: CGFloat = 6
    static let firstChatViewBottomPadding: CGFloat = -30
}

// MARK: TextField Container View Constants
enum TextFieldContainerViewConstants {
    static let containerCornerRadius: CGFloat = 24
    static let containerBorderWidth: CGFloat = 1
    static let textFieldLeadingPadding: CGFloat = 22
    static let textFieldBottomTopAndTrailingPadding: CGFloat = 12
    static let buttonWidthAndHeight: CGFloat = 30
    static let sendButtonTrailingPadding: CGFloat = -10
    static let sendButtonBottomPadding: CGFloat = -12
}

// MARK: Chat View Constants
enum ChatViewConstants {
    static let textFieldFont: CGFloat = 14
    static let containterWitdthConstant: CGFloat = -32
    static let containterHeightConstant: CGFloat = 48
}

// MARK: Scrollable Text Field Constants
enum ScrollableTextFieldConstants {
    static let leadingPadding: CGFloat = 3
    static let topPadding: CGFloat = 3
    static var placeholder = "დაწერე შეტყობინება..."
    static var maxNumberOfLines = 5
}

// MARK: Switch Button State
enum SwitcherState {
    case dark
    case light
}
