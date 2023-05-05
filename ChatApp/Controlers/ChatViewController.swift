//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    // MARK: Outlets
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = MessageAppColors.yellowViewColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var switcherButton = SwitcherButton()
    
    private lazy var firstChatView = ChatView()
    
    private lazy var secondChatView = ChatView()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        addSubViews()
        setUpConstraints()
    }
    
    //MARK: Setting Up Constratins
    private func setUpConstraints() {
        setUpDividerViewConstraints()
        setUpSwitcherConstraints()
        setUpFirstChatVIewConstraints()
        setUpSecondChatViewConstraints()
    }
    
    // MARK: Set Up Divider View Constraints
    private func setUpDividerViewConstraints() {
        NSLayoutConstraint.activate([
            dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dividerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: ChatViewControllerConstants.dividerViewHeight)
        ])
    }
    
    // MARK: Set Up Switcher Constraints
    private func setUpSwitcherConstraints() {
        NSLayoutConstraint.activate([
            switcherButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -(view.frame.width * 0.032)),
            switcherButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: ChatViewControllerConstants.switcherTopPadding),
            switcherButton.widthAnchor.constraint(equalToConstant: ChatViewControllerConstants.switcherWidth),
            switcherButton.heightAnchor.constraint(equalToConstant: ChatViewControllerConstants.switcherHeight)
        ])
    }
    
    // MARK: Set Up First Chat View Constraints
    private func setUpFirstChatVIewConstraints() {
        NSLayoutConstraint.activate([
            firstChatView.topAnchor.constraint(equalTo: switcherButton.bottomAnchor),
            firstChatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstChatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstChatView.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: ChatViewControllerConstants.firstChatViewBottomPadding)
        ])
    }
    
    // MARK: Set Up Second Chat View Constraints
    private func setUpSecondChatViewConstraints() {
        NSLayoutConstraint.activate([
            secondChatView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            secondChatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondChatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondChatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: Adding SubViews
    private func addSubViews() {
        [dividerView, switcherButton, firstChatView, secondChatView].forEach { [weak self] view in
            self?.view.addSubview(view)
        }
    }
    
    // MARK: UI Set Up
    private func setUpUI() {
        switcherButton.delegate = self
        [switcherButton, firstChatView, secondChatView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setUpViewsForDarkMode() {
        view.backgroundColor = MessageAppColors.backgroundDarkModeColor
        dividerView.backgroundColor = MessageAppColors.darkModeYellowViewColor
        [firstChatView, secondChatView].forEach { view in
            view?.backgroundColor = MessageAppColors.backgroundDarkModeColor
        }
        [firstChatView.textFieldContainer, secondChatView.textFieldContainer].forEach { view in
            [view, view.textField].forEach { view in
                view?.backgroundColor = MessageAppColors.backgroundDarkModeColor
            }
            view.textField.textColor = MessageAppColors.darkModeTextColor
        }
    }
    
    private func setUpViewsForLightMode() {
        view.backgroundColor = .systemBackground
        dividerView.backgroundColor = MessageAppColors.yellowViewColor
        [firstChatView,secondChatView].forEach { view in
            view?.backgroundColor = .systemBackground
        }
        [firstChatView.textFieldContainer, secondChatView.textFieldContainer].forEach { view in
            [view, view.textField].forEach { view in
                view?.backgroundColor = .systemBackground
            }
            view.textField.textColor = MessageAppColors.lightModeTextColor
        }
    }
}

// MARK: Switcher Button Delegate
extension ChatViewController: SwitcherButtonDelegate {
    func SwitcherIsPressed() {
        UIView.animate(withDuration: 0.5,
                       animations: {
            if self.switcherButton.switcherState == .light {
                self.setUpViewsForDarkMode()
            } else if self.switcherButton.switcherState == .dark {
                self.setUpViewsForLightMode()
            }
        },completion: nil)
    }
}
