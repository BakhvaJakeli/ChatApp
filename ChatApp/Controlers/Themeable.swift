//
//  ViewTheme.swift
//  ChatApp
//
//  Created by bakhva  on 23.05.23.
//

import Foundation

protocol Themeable {
    func applyDarkMode()
    func applyLightMode()
}

extension Themeable where Self: ChatViewController {
    func applyDarkMode() {
        view.backgroundColor = ChatAppColors.backgroundDarkModeColor
        dividerView.backgroundColor = ChatAppColors.darkModeYellowViewColor
        [firstChatView, secondChatView].forEach { view in
            view?.backgroundColor = ChatAppColors.backgroundDarkModeColor
        }
        [firstChatView.textFieldContainer, secondChatView.textFieldContainer].forEach { view in
            [view, view.textField].forEach { view in
                view?.backgroundColor = ChatAppColors.backgroundDarkModeColor
            }
            view.textField.textColor = ChatAppColors.darkModeTextColor
        }
    }
    
    func applyLightMode() {
        view.backgroundColor = .systemBackground
        dividerView.backgroundColor = ChatAppColors.yellowViewColor
        [firstChatView, secondChatView].forEach { view in
            view?.backgroundColor = .systemBackground
        }
        [firstChatView.textFieldContainer, secondChatView.textFieldContainer].forEach { view in
            [view, view.textField].forEach { view in
                view?.backgroundColor = .systemBackground
            }
            view.textField.textColor = ChatAppColors.lightModeTextColor
        }
    }
}
