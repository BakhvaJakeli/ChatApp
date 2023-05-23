//
//  SenderChatBubbleView.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

class SenderChatBubbleView: UIView {
    
    //MARK: Components
    lazy var color: UIColor = ChatAppColors.senderBubbleColor
    
    private lazy var mainTextBubble: UIView = {
        let bubble = UIView()
        bubble.translatesAutoresizingMaskIntoConstraints = false
        bubble.backgroundColor = color
        bubble.layer.cornerRadius = SenderChatBubbleViewConstants.mainTextBubbleCornerRadius
        return bubble
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: SenderChatBubbleViewConstants.messageLabelFont)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: SenderChatBubbleViewConstants.dateLabelFont)
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingSubviews()
        constraints()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Adding Sub Views
    private func addingSubviews() {
        addSubview(mainTextBubble)
        addSubview(dateLabel)
        mainTextBubble.addSubview(messageLabel)
    }
    
    // MARK: Constraints
    private func constraints() {
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: mainTextBubble.leadingAnchor, constant: SenderChatBubbleViewConstants.messageLabelPadding),
            messageLabel.bottomAnchor.constraint(equalTo: mainTextBubble.bottomAnchor, constant: -SenderChatBubbleViewConstants.messageLabelPadding),
            messageLabel.topAnchor.constraint(equalTo: mainTextBubble.topAnchor, constant: SenderChatBubbleViewConstants.messageLabelPadding),
            messageLabel.trailingAnchor.constraint(equalTo: mainTextBubble.trailingAnchor, constant: -SenderChatBubbleViewConstants.messageLabelPadding),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: SenderChatBubbleViewConstants.messageLabelMaximumWidth),

            mainTextBubble.topAnchor.constraint(equalTo: topAnchor, constant: SenderChatBubbleViewConstants.mainTextBubbleTopPadding),
            mainTextBubble.trailingAnchor.constraint(equalTo: trailingAnchor, constant: SenderChatBubbleViewConstants.mainTextBubbleTrailingPadding),
            mainTextBubble.heightAnchor.constraint(greaterThanOrEqualToConstant: SenderChatBubbleViewConstants.mainTextBubbleMinHeight),
            mainTextBubble.widthAnchor.constraint(greaterThanOrEqualToConstant: SenderChatBubbleViewConstants.mainTextBubbleMinWidth),
            
            dateLabel.topAnchor.constraint(equalTo: mainTextBubble.bottomAnchor, constant: SenderChatBubbleViewConstants.dataLabelTopPadding),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: SenderChatBubbleViewConstants.dataLabelTrailingPadding)
        ])
    }
    
    // MARK: Congif UI
    private func configUI() {
        backgroundColor = .clear
    }
    
    // MARK: Update Content Size
    override var intrinsicContentSize: CGSize {
        let labelSize = messageLabel.sizeThatFits(CGSize(width: SenderChatBubbleViewConstants.messageLabelMaximumWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let bubbleWidth = labelSize.width + 2 * SenderChatBubbleViewConstants.messageLabelPadding
        let bubbleHeight = labelSize.height + 2 * SenderChatBubbleViewConstants.messageLabelPadding + SenderChatBubbleViewConstants.intrinsicContentSizeHeight
        
        return CGSize(width: bubbleWidth, height: bubbleHeight)
    }
    
    // MARK: BazierPath bubbles
    override func draw(_ rect: CGRect) {
        
        let firstBubble = UIBezierPath(
            ovalIn: CGRect(
                x: mainTextBubble.frame.maxX - 15,
                y: mainTextBubble.frame.maxY - 17,
                width: SenderChatBubbleViewConstants.firstBubbleHeight,
                height: SenderChatBubbleViewConstants.firstBubbleHeight))
        color.setFill()
        firstBubble.fill()
        
        let secondBubble = UIBezierPath(
            ovalIn: CGRect(
                x: mainTextBubble.frame.maxX + 10,
                y: mainTextBubble.frame.maxY,
                width: SenderChatBubbleViewConstants.secondBubbleHeight,
                height: SenderChatBubbleViewConstants.secondBubbleHeight))
        color.setFill()
        secondBubble.fill()
    }
}

// MARK: -SenderChatBubbleView Constants
private extension SenderChatBubbleView {
    enum SenderChatBubbleViewConstants {
        static let messageLabelPadding: CGFloat = 10
        static let messageLabelMaximumWidth: CGFloat = 220
        static let mainTextBubbleTopPadding: CGFloat = 10
        static let mainTextBubbleTrailingPadding: CGFloat = -30
        static let mainTextBubbleMinHeight: CGFloat = 50
        static let mainTextBubbleMinWidth: CGFloat = 50
        static let dataLabelTopPadding: CGFloat = 4
        static let dataLabelTrailingPadding: CGFloat = -45
        static let mainTextBubbleCornerRadius: CGFloat = 25
        static let messageLabelFont: CGFloat = 14
        static let dateLabelFont: CGFloat = 8
        static let intrinsicContentSizeHeight: CGFloat = 40
        static let firstBubbleHeight: CGFloat = 20
        static let secondBubbleHeight: CGFloat = 10
    }
}
