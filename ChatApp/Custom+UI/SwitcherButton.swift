//
//  SwitchButton.swift
//  ChatApp
//
//  Created by bakhva  on 28.04.23.
//

import UIKit

// MARK: Switcher Button Delegate
protocol SwitcherButtonDelegate: AnyObject {
    func SwitcherIsPressed(_ button: SwitcherButton)
}

final class SwitcherButton: UIButton {
    
    weak var delegate: SwitcherButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Button Configuration
    private func configureButton() {
        setImage(.lightModeImage, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Button Action
    @objc private func buttonPressed() {
        isEnabled = false
        delegate?.SwitcherIsPressed(self)
        UIView.animate(withDuration: 0.5, animations: {
            if self.currentImage == .lightModeImage {
                self.setImage(.darkModeImage, for: .normal)
            } else {
                self.setImage(.lightModeImage, for: .normal)
            }
        }, completion: {_ in
            self.isEnabled = true
        })
    }
}
