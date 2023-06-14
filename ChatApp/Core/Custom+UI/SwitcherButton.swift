//
//  SwitchButton.swift
//  ChatApp
//
//  Created by bakhva  on 28.04.23.
//

import UIKit

// MARK: Switcher Button Delegate
protocol SwitcherButtonDelegate: AnyObject {
    func switcherIsPressed(_ state: ChatAppComponents.SwitcherState)
}

final class SwitcherButton: UIButton {
    
    weak var delegate: SwitcherButtonDelegate?
    
    var switcherState: ChatAppComponents.SwitcherState = .light {
        didSet {
            UserDefaults.standard.set(switcherState.rawValue, forKey: "switcherState")
            configureButton()
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        configureButton()
        setUpUserDefaults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Button Configuration
    private func configureButton() {
        switch switcherState {
        case .dark:
            setImage(ChatAppImages.darkModeImage, for: .normal)
        case .light:
            setImage(ChatAppImages.lightModeImage, for: .normal)
        }
    }
    
    // MARK: Set Up UserDefaults
    private func setUpUserDefaults() {
        if let switcherStateRawValue = UserDefaults.standard.string(forKey: "switcherState"),
           let savedSwitcherState = ChatAppComponents.SwitcherState(rawValue: switcherStateRawValue) {
            switcherState = savedSwitcherState
        } else {
            switcherState = .light 
        }
    }
    
    // MARK: Call Delegate
    func callDelegate() {
        delegate?.switcherIsPressed(switcherState)
    }
    
    // MARK: Button Action
    @objc private func buttonPressed() {
        isEnabled = false
        UIView.animate(withDuration: SwitcherButtonConstants.animationDuration,
                       animations: {
            switch self.switcherState {
            case .light :
                self.switcherState = .dark
                self.setImage(ChatAppImages.darkModeImage, for: .normal)
                
            case .dark:
                self.switcherState = .light
                self.setImage(ChatAppImages.lightModeImage, for: .normal)
            }
        }, completion: {_ in
            self.isEnabled = true
        })
        delegate?.switcherIsPressed(switcherState)
    }
}

private extension SwitcherButton {
    enum SwitcherButtonConstants {
        static let animationDuration: CGFloat = 0.5
    }
}
