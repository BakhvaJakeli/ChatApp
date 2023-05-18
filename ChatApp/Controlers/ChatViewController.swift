//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

final class ChatViewController: UIViewController {
    
    let viewModel = ChatViewModel()
    
    // MARK: Outlets
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ChatAppColors.yellowViewColor
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
        viewModel.getMessage()
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                [self.firstChatView.chatTableView, self.secondChatView.chatTableView].forEach{$0.reloadData()}
            }
        }
        switcherButton.delegate = self
        firstChatView.textFieldContainer.delegate = self
        secondChatView.textFieldContainer.delegate = self
        firstChatView.configTableView(dataSource: self, delegate: self)
        secondChatView.configTableView(dataSource: self, delegate: self)
        [switcherButton, firstChatView, secondChatView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        [firstChatView.chatTableView, secondChatView.chatTableView].forEach{$0.reloadData()}
    }
    
    // MARK: UI configuration
    private func configUI() {
        switcherButton.callDelegate()
    }
    
    private func setUpViewsForDarkMode() {
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
    
    private func setUpViewsForLightMode() {
        view.backgroundColor = .systemBackground
        dividerView.backgroundColor = ChatAppColors.yellowViewColor
        [firstChatView,secondChatView].forEach { view in
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

// MARK: - Switcher Button Delegate
extension ChatViewController: SwitcherButtonDelegate {
    func switcherIsPressed(_ state: SwitcherState) {
        UIView.animate(withDuration: 0.5,
                       animations: {
            switch state {
            case .dark:
                self.setUpViewsForDarkMode()
            case .light:
                self.setUpViewsForLightMode()
            }
        },completion: nil)
    }
}

// MARK: - Send Button Delegate
extension ChatViewController: sendButtonDelegate {
    func sendMessage(_ textField: ScrollableTextField) {
        let firstTextField = firstChatView.textFieldContainer.textField
        let secondTextField = secondChatView.textFieldContainer.textField
        if textField == firstTextField {
            viewModel.createMessage(with: textField.text, senderID: 1)
            textField.text = ""
        } else if textField == secondTextField {
            viewModel.createMessage(with: textField.text, senderID: 2)
            textField.text = ""
        }
//        viewModel.deleteAllData(entity: "Message")
    }
}

// MARK: - Table View functions
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]
        let senderCell = tableView.dequeueReusableCell(withIdentifier: SenderTableViewCell.identifier) as! SenderTableViewCell
        let receiverCell = tableView.dequeueReusableCell(withIdentifier: ReceiverTableViewCell.identifier) as! ReceiverTableViewCell
        switch tableView {
        case firstChatView.chatTableView:
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
        case secondChatView.chatTableView:
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    }
}
