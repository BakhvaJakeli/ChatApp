//
//  ReceiverChatBubbleVIew.swift
//  ChatApp
//
//  Created by bakhva  on 27.04.23.
//

import UIKit

final class ReceiverChatBubbleVIew: UIView {
    
    let textLabel = UILabel()
    let timeLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
    
        let mainTextBubble = UIBezierPath(roundedRect: CGRect(x: 32,
                                                              y: frame.minY,
                                                              width: textLabel.frame.width,
                                                              height: textLabel.frame.height),
                                          cornerRadius: 25)
        UIColor.gray.setFill()
        mainTextBubble.fill()

        let firstBubble = UIBezierPath(ovalIn: CGRect(x: mainTextBubble.bounds.minX - 5,
                                                      y: mainTextBubble.bounds.maxY - 18,
                                                      width: 20,
                                                      height: 20))
        UIColor.gray.setFill()
        firstBubble.fill()

        let secondBubble = UIBezierPath(ovalIn: CGRect(x: mainTextBubble.bounds.minX - 16,
                                                       y: mainTextBubble.bounds.maxY - 3,
                                                       width: 10,
                                                       height: 10))
        UIColor.gray.setFill()
        secondBubble.fill()
    }
}
