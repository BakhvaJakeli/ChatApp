//
//  ChatView.swift
//  ChatApp
//
//  Created by bakhva  on 29.04.23.
//

import UIKit

final class ChatView: UIView {
    
    // MARK: Components
    lazy var textFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.textField.font = .systemFont(ofSize: ChatViewConstants.textFieldFont)
        return container
    }()
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
    }
    
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
            chatTableView.bottomAnchor.constraint(equalTo: textFieldContainer.topAnchor),
        ])
    }
    
    //MARK: Text Field Container Constraints
    private func textFieldContainerConstraints() {
        NSLayoutConstraint.activate([
            textFieldContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFieldContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: ChatViewConstants.containterWitdthConstant),
            textFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: ChatViewConstants.containterHeightConstant),
        ])
    }
}

// MARK: Table View Functions
extension ChatView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
