//
//  TextFIeldContainer.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

protocol sendButtonDelegate:AnyObject {
    func sendMessage(_ textField: ScrollableTextField)
}

final class TextFieldContainerView: UIView {
    
    weak var delegate: sendButtonDelegate?
    
    // MARK: Outlets
    let textField = ScrollableTextField()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = ChatAppColors.sendButtonCollor
        configuration.image = ChatAppImages.sendButtomImmage
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
        layer.borderColor = ChatAppColors.borderColor.cgColor
        [textField,sendButton].forEach( { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        })
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
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
    
    // MARK: Button Action
    @objc func sendMessage() {
        guard let text = textField.text else {return}
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {return}
        delegate?.sendMessage(textField)
    }
}

// MARK: - Themeable Protocol for Device Mode
extension TextFieldContainerView: Themeable {
    func isDarkModeOn(isTrue: Bool) {
        if isTrue {
            textField.textColor = ChatAppColors.darkModeTextColor
            backgroundColor = ChatAppColors.backgroundDarkModeColor
        }
        else {
            textField.textColor = ChatAppColors.lightModeTextColor
            backgroundColor = .systemBackground
        }
        textField.isDarkModeOn(isTrue: isTrue)
    }
}

// MARK: - Text Field Containter Constatns
private extension TextFieldContainerView {
    enum TextFieldContainerViewConstants {
        static let containerCornerRadius: CGFloat = 24
        static let containerBorderWidth: CGFloat = 1
        static let textFieldLeadingPadding: CGFloat = 22
        static let textFieldBottomTopAndTrailingPadding: CGFloat = 12
        static let buttonWidthAndHeight: CGFloat = 30
        static let sendButtonTrailingPadding: CGFloat = -10
        static let sendButtonBottomPadding: CGFloat = -12
    }
}
