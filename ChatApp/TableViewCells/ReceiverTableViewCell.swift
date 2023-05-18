//
//  ReceiverTableViewCell.swift
//  ChatApp
//
//  Created by bakhva  on 11.05.23.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {

    static let identifier = "ReceiverTableViewCell"
    
    lazy var bubble = ReceiverChatBubbleVIew()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        constraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        bubble.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubble)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            bubble.topAnchor.constraint(equalTo: topAnchor),
            bubble.leadingAnchor.constraint(equalTo: leadingAnchor),
            bubble.bottomAnchor.constraint(equalTo: bottomAnchor),
            bubble.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configCell(with message: Message) {
        bubble.messageLabel.text = message.text
        bubble.dateLabel.text = message.sendDate
    }
}
