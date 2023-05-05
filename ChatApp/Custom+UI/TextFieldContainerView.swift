//
//  TextFIeldContainer.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit


final class TextFieldContainerView: UIView {
    
    // MARK: Outlets
    let textField = ScrollableTextField()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = MessageAppColors.sendButtonCollor
        configuration.image = MessageAppImages.sendButtomImmage
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        
        return button
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubViews()
        configUI()
        setUpConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Adding Subviews
    private func addSubViews() {
        addSubview(textField)
        addSubview(sendButton)
        
    }
    
    // MARK: Configuring UI
    private func configUI() {
        layer.cornerRadius = TextFieldContainerViewConstants.containerCornerRadius
        layer.borderWidth = TextFieldContainerViewConstants.containerBorderWidth
        layer.borderColor = MessageAppColors.borderColor.cgColor
        [textField,sendButton].forEach( { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    // MARK: Setting Up Constraints
    private func setUpConstraints() {
        setUpTextFieldConstraints()
        setUpButtonConstraints()
    }
    
    // MARK: Set Up Text Field
    private func setUpTextFieldConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: TextFieldContainerViewConstants.textFieldLeadingPadding),
            textField.topAnchor.constraint(equalTo: topAnchor,
                                           constant: TextFieldContainerViewConstants.textFieldBottomTopAndTrailingPadding),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -TextFieldContainerViewConstants.textFieldBottomTopAndTrailingPadding),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor,
                                              constant: -TextFieldContainerViewConstants.textFieldBottomTopAndTrailingPadding),
        ])
    }
    
    // MARK: Set Up Button
    private func setUpButtonConstraints() {
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: TextFieldContainerViewConstants.sendButtonTrailingPadding),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                               constant: TextFieldContainerViewConstants.sendButtonBottomPadding),
            sendButton.widthAnchor.constraint(equalToConstant: TextFieldContainerViewConstants.buttonWidthAndHeight),
            sendButton.heightAnchor.constraint(equalToConstant: TextFieldContainerViewConstants.buttonWidthAndHeight)
        ])
    }
}

