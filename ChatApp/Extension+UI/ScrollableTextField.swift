//
//  CustomClass.swift
//  ChatApp
//
//  Created by bakhva  on 25.04.23.
//

import UIKit
import CoreMotion

class ScrollableTextField: UITextView, UITextViewDelegate {

    var placeholder = "დაწერე შეტყობინება..."
    var placeholderColor: UIColor = .lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }

    private let placeholderLabel = UILabel()

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        delegate = self
        autocorrectionType = .no

        configurePlaceholderLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var maxNumberOfLines = 5
    var lineHeight: CGFloat {
        if let font = font {
            return font.lineHeight
        }
        return 0
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        let maxHeight = CGFloat(maxNumberOfLines) * lineHeight + textContainerInset.top + textContainerInset.bottom
        if size.height > maxHeight {
            size.height = maxHeight
            isScrollEnabled = true
        } else {
            isScrollEnabled = false
        }
        return size
    }

    override var text: String! {
        didSet {
            invalidateIntrinsicContentSize()
            updatePlaceholderVisibility()
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        invalidateIntrinsicContentSize()
        updatePlaceholderVisibility()
    }

    private func configurePlaceholderLabel() {
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = font
        placeholderLabel.isHidden = !text.isEmpty
    }

    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
