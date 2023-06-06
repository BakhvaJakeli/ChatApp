//
//  ChatView.swift
//  ChatApp
//
//  Created by bakhva  on 29.04.23.
//

import UIKit

final class ChatView: UIView {
    
    // MARK: Components
    private lazy var textFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.getTextField().font = .systemFont(ofSize: ChatViewConstants.textFieldFont)
        
        return container
    }()
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(SenderTableViewCell.self, forCellReuseIdentifier: SenderTableViewCell.identifier)
        tableView.register(ReceiverTableViewCell.self, forCellReuseIdentifier: ReceiverTableViewCell.identifier)
        
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
    @available(*, unavailable)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Adding SubViews
    private func addSubviews() {
        addSubview(chatTableView)
        addSubview(textFieldContainer)
    }
    
    // MARK: Adding Constraints
    private func addConstraints() {
        chatTableViewConstraints()
        textFieldContainerConstraints()
    }
    
    // MARK: Chat Table View Constraints
    private func chatTableViewConstraints() {
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: topAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: textFieldContainer.topAnchor)
        ])
    }
    
    // MARK: Text Field Container Constraints
    private func textFieldContainerConstraints() {
        NSLayoutConstraint.activate([
            textFieldContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: ChatViewConstants.containterWitdthConstant),
            textFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: ChatViewConstants.containterHeightConstant)
        ])
    }
    
    func textFieldDelegate(_ self: UIViewController) {
        textFieldContainer.delegate = self as? sendButtonDelegate
    }
    
    func getText() -> String {
        textFieldContainer.getText()
    }
    
    func getTextField() -> ScrollableTextField {
        textFieldContainer.getTextField()
    }
    
    func getTableView() -> UITableView {
        chatTableView
    }
}

// MARK: - Themeable Protocol for Device Mode
extension ChatView: Themeable {
    func isDarkModeOn(_ isTrue: Bool) {
        if isTrue {
            backgroundColor = ChatAppColors.backgroundDarkModeColor
        } else {
            backgroundColor = .systemBackground
        }
        textFieldContainer.isDarkModeOn(isTrue)
    }
}
// MARK: - Table View Functions
extension ChatView {
    public func configTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        chatTableView.dataSource = dataSource
        chatTableView.delegate = delegate
    }
}

// MARK: - Chat View Constants
private extension ChatView {
    enum ChatViewConstants {
        static let textFieldFont: CGFloat = 14
        static let containterWitdthConstant: CGFloat = -32
        static let containterHeightConstant: CGFloat = 48
    }
}
