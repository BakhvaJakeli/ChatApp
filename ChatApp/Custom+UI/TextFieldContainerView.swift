//
//  TextFIeldContainer.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit


final class TextFieldContainerView: UIView {

    let textField = ScrollableTextField()
    var sendButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground
        makeButton()
        addSubViews()
        configUI()
        setUpConstraints()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Button Configuration
    private func makeButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .sendButtonCollor
        configuration.image = .sendButtomImmage
        configuration.cornerStyle = .capsule
        
        sendButton = UIButton(configuration: configuration,
                                  primaryAction: nil)
    }
    
    // MARK: Adding Subviews
    private func addSubViews() {
        addSubview(textField)
        addSubview(sendButton)
        [textField,sendButton].forEach( { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    // MARK: Configuring UI
    private func configUI() {
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
    }
    
    // MARK: Setting Up Constraints
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            // MARK: Set Text Field Constraints
            textField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: 22),
            textField.topAnchor.constraint(equalTo: topAnchor,
                                           constant: 12),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor,
                                              constant: -12),
            
            // MARK: Set Button Constraints
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -10),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                               constant: -12),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

