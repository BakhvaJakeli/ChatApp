//
//  SwitchButton.swift
//  ChatApp
//
//  Created by bakhva  on 28.04.23.
//

import UIKit

// MARK: Switcher Button Delegate
protocol SwitcherButtonDelegate: AnyObject {
    func switcherIsPressed(_ state: SwitcherState)
}

final class SwitcherButton: UIButton {
    
    var switcherState: SwitcherState = .light
    
    weak var delegate: SwitcherButtonDelegate?
    
    //MARK: Init
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
        setImage(MessageAppImages.lightModeImage, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Button Action
    @objc private func buttonPressed() {
        isEnabled = false
        delegate?.switcherIsPressed(switcherState)
        UIView.animate(withDuration: 0.5,
                       animations: {
            switch self.switcherState {
            case .light :
                self.switcherState = .dark
                self.setImage(MessageAppImages.darkModeImage, for: .normal)
                
            case .dark:
                self.switcherState = .light
                self.setImage(MessageAppImages.lightModeImage, for: .normal)
            }
        }, completion: {_ in
            self.isEnabled = true
        })
    }
}
