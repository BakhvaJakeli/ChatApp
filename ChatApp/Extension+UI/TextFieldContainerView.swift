//
//  TextFIeldContainer.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit


class TextFieldContainerView: UIView {

    let textField = ScrollableTextField()
    let sendButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)

        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = Constants.Colors.sendButtonCollor
        configuration.image = Constants.Images.sendButtomImmage
        configuration.cornerStyle = .capsule
        
        let sendButton = UIButton(configuration: configuration,
                                  primaryAction: nil)
        backgroundColor = .white

        textField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textField)
        addSubview(sendButton)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.borderColor.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

