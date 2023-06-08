//
//  SenderTableViewCell.swift
//  ChatApp
//
//  Created by bakhva  on 11.05.23.
//

import UIKit

final class SenderTableViewCell: UITableViewCell {
    
    static let identifier = "SenderTableViewCell"
    
    private let bubble = SenderChatBubbleView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        constraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        bubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        contentView.addSubview(bubble)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bubble.topAnchor.constraint(equalTo: contentView.topAnchor),
            bubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
    
        ])
    }
    
    func configCell(with message: Message) {
        bubble.setUpBubble(with: message)
    }
}
