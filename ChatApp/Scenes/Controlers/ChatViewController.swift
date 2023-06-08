//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    private let viewModel = ChatViewModel()
    
    // MARK: Outlets
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ChatAppColors.yellowViewColor
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
        setUpUI()
        configUI()
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
            // gaitane es constanshi
            switcherButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: ChatViewControllerConstants.switcherRightPadding),
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
        viewModel.getMessage()
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                [self.firstChatView.getTableView(), self.secondChatView.getTableView()].forEach{$0.reloadData()}
            }
        }
        switcherButton.delegate = self
        firstChatView.textFieldDelegate(self)
        secondChatView.textFieldDelegate(self)
        firstChatView.configTableView(dataSource: self, delegate: self)
        secondChatView.configTableView(dataSource: self, delegate: self)
        [switcherButton, firstChatView, secondChatView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        [firstChatView.getTableView(), secondChatView.getTableView()].forEach{$0.reloadData()}
        view.backgroundColor = .systemBackground
    }
    
    // MARK: UI configuration
    private func configUI() {
        switcherButton.callDelegate()
        hideKeyboardWhenTappedAround()
        scrollToLastMessage()
    }
    
    private func scrollToLastMessage() {
        let lastRowIndex = viewModel.messages.count - 1
        if lastRowIndex > 0 {
            let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
            [firstChatView.getTableView(), secondChatView.getTableView()].forEach { tableView in
                DispatchQueue.main.async {
                    tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
                }
            }
        }
    }
}

// MARK: - Themeable Protocol for Light and Dark Mode
extension ChatViewController: Themeable {
    func isDarkModeOn(_ isTrue: Bool) {
        if isTrue {
            view.backgroundColor = ChatAppColors.backgroundDarkModeColor
        } else {
            view.backgroundColor = .systemBackground
        }
    }
}

// MARK: - Switcher Button Delegate
extension ChatViewController: SwitcherButtonDelegate {
    func switcherIsPressed(_ state: ChatAppComponents.SwitcherState) {
        UIView.animate(withDuration: ChatViewControllerConstants.animationDuration,
                       animations: {
            switch state {
            case .dark:
                self.isDarkModeOn(true)
                self.firstChatView.isDarkModeOn(true)
                self.secondChatView.isDarkModeOn(true)
            case .light:
                self.isDarkModeOn(false)
                self.firstChatView.isDarkModeOn(false)
                self.secondChatView.isDarkModeOn(false)
            }
        },completion: nil)
    }
}

// MARK: - Send Button Delegate
extension ChatViewController: sendButtonDelegate {
    func sendMessage(_ textField: ScrollableTextField) {
        let firstText = firstChatView.getText()
        let secondtext = secondChatView.getText()
        let firstTextField = firstChatView.getTextField()
        let secondTextField = secondChatView.getTextField()
        if textField == firstTextField {
            viewModel.createMessage(with: firstText, senderID: 1)
            textField.text = ""
        } else if textField == secondTextField {
            viewModel.createMessage(with: secondtext, senderID: 2)
            textField.text = ""
        }
        scrollToLastMessage()
//        viewModel.deleteAllData()
    }
}

// MARK: - Keyboard Hide Function
extension ChatViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Table View functions
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]
        guard let senderCell = tableView.dequeueReusableCell(withIdentifier: SenderTableViewCell.identifier) as? SenderTableViewCell else {return UITableViewCell()}
        guard let receiverCell = tableView.dequeueReusableCell(withIdentifier: ReceiverTableViewCell.identifier) as? ReceiverTableViewCell else {return UITableViewCell()}
        switch tableView {
        case firstChatView.getTableView():
            switch message.senderID {
            case 1:
                senderCell.configCell(with: message)
                return senderCell
            case 2:
                receiverCell.configCell(with: message)
                return receiverCell
            default:
                return UITableViewCell()
            }
        case secondChatView.getTableView():
            switch message.senderID {
            case 1:
                receiverCell.configCell(with: message)
                return receiverCell
            case 2:
                senderCell.configCell(with: message)
                return senderCell
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}

// MARK: -View Controller Constants
private extension ChatViewController {
    enum ChatViewControllerConstants {
        static let switcherWidth: CGFloat = 54
        static let switcherHeight: CGFloat = 27
        static let switcherTopPadding: CGFloat = 8
        static let dividerViewHeight: CGFloat = 6
        static let firstChatViewBottomPadding: CGFloat = -30
        static let animationDuration: CGFloat = 0.5
        static let switcherRightPadding: CGFloat = -20
    }
}
