//
//  ChatView.swift
//  ChatApp
//
//  Created by bakhva  on 29.04.23.
//

import UIKit

final class ChatView: UIView {
    
    // MARK: Outlets
    let TextFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.textField.font = .systemFont(ofSize: ChatViewConstants.textFieldFont)

        return container
    }()
    
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setting up UI
    private func configUI() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }
    
    // MARK: Adding SubViews
    private func addSubviews() {
        addSubview(chatTableView)
        addSubview(TextFieldContainer)
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
            chatTableView.bottomAnchor.constraint(equalTo: TextFieldContainer.topAnchor),
        ])
    }
    
    //MARK: Text Field Container Constraints
    private func textFieldContainerConstraints() {
        NSLayoutConstraint.activate([
            TextFieldContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            TextFieldContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            TextFieldContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: ChatViewConstants.containterWitdthConstant),
            TextFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: ChatViewConstants.containterHeightConstant),
        ])
    }
}

// MARK: Table View Functions
extension ChatView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
