//
//  CustomClass.swift
//  ChatApp
//
//  Created by bakhva  on 25.04.23.
//

import UIKit

final class ScrollableTextField: UITextView, UITextViewDelegate {
    
    var placeholder = "დაწერე შეტყობინება..."
    var maxNumberOfLines = 5

    var lineHeight: CGFloat {
        let font = font?.lineHeight ?? 0
        return font
    }
    
    var placeholderColor: UIColor = .lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override var text: String! {
        didSet {
            invalidateIntrinsicContentSize()
            updatePlaceholderVisibility()
        }
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

    
    func textViewDidChange(_ textView: UITextView) {
        invalidateIntrinsicContentSize()
        updatePlaceholderVisibility()
    }
    
    private func configurePlaceholderLabel() {
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = font
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
