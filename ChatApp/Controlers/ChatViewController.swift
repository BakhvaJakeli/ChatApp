//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    // MARK: Outlets
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellowViewColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
        
    private let switcherButton = SwitcherButton()
    
    private let firstChatView = ChatView()
    
    private let secondChatView = ChatView()
    
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
        NSLayoutConstraint.activate([
            // MARK: Screen Split Constraints
            dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dividerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: ChatViewControllerConstants.dividerViewHeight),
            
            // MARK: Switch Constraints
            switcherButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -(view.frame.width * 0.032)),
            switcherButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: ChatViewControllerConstants.switcherTopPadding),
            switcherButton.widthAnchor.constraint(equalToConstant: ChatViewControllerConstants.switcherWidth),
            switcherButton.heightAnchor.constraint(equalToConstant: ChatViewControllerConstants.switcherHeight),
            
            // MARK: First Chat View Constraints
            firstChatView.topAnchor.constraint(equalTo: switcherButton.bottomAnchor),
            firstChatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstChatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstChatView.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: ChatViewControllerConstants.firstChatViewBottomPadding),
            
            //MARK: Second Chat View Constraints
            secondChatView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
            secondChatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondChatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondChatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    // MARK: Adding SubViews
    private func addSubViews() {
        [dividerView, switcherButton, firstChatView, secondChatView].forEach { [weak self] theView in
            self?.view.addSubview(theView)
        }
    }
    
    // MARK: UI Set Up
    private func setUpUI() {
        switcherButton.delegate = self
        [switcherButton, firstChatView, secondChatView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// MARK: Switcher Button Delegate
extension ChatViewController: SwitcherButtonDelegate {
    
    func SwitcherIsPressed(_ button: SwitcherButton) {
        UIView.animate(withDuration: 0.5, animations: {
            if self.switcherButton.currentImage == .lightModeImage {
                self.setUpViewsForDarkMode()
            } else {
                self.setUpViewsForLightMode()
            }
        }, completion: nil)
    }
    
    private func setUpViewsForDarkMode() {
        view.backgroundColor = .backgroundDarkModeColor
        dividerView.backgroundColor = .darkModeYellowViewColor
        [firstChatView, secondChatView].forEach { view in
            view?.backgroundColor = .backgroundDarkModeColor
        }
        [firstChatView.TextFieldContainer, secondChatView.TextFieldContainer].forEach { view in
            [view, view.textField].forEach { theView in
                theView?.backgroundColor = .backgroundDarkModeColor
            }
            view.textField.textColor = .darkModeTextColor
        }
    }
    
    private func setUpViewsForLightMode() {
        view.backgroundColor = .systemBackground
        dividerView.backgroundColor = .yellowViewColor
        [firstChatView,secondChatView].forEach { view in
            view?.backgroundColor = .systemBackground
        }
        [firstChatView.TextFieldContainer, secondChatView.TextFieldContainer].forEach { view in
            [view, view.textField].forEach { theView in
                theView?.backgroundColor = .systemBackground
            }
            view.textField.textColor = .lightModeTextColor
        }
    }
}
