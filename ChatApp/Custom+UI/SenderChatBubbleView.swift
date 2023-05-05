//
//  SenderChatBubbleView.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

class SenderChatBubbleView: UIView {
    
    let textLabel = UILabel()
    let timeLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        let mainTextBubble = UIBezierPath(
            roundedRect: CGRect(
                x: frame.minX,
                y: frame.minY,
                width: textLabel.frame.width,
                height: textLabel.frame.height),
            cornerRadius: 25)
        UIColor.gray.setFill()
        mainTextBubble.fill()
        
        let firstBubble = UIBezierPath(
            ovalIn: CGRect(
                x: frame.minX + mainTextBubble.bounds.width - 10,
                y: frame.minY + mainTextBubble.bounds.height - 15,
                width: 20,
                height: 20))
        UIColor.gray.setFill()
        firstBubble.fill()
        
        let secondBubble = UIBezierPath(
            ovalIn: CGRect(
                x: frame.minX + mainTextBubble.bounds.width + 10,
                y: frame.minY + mainTextBubble.bounds.height,
                width: 10,
                height: 10))
        UIColor.gray.setFill()
        secondBubble.fill()
    }
}
