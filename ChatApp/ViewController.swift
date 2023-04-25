//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

class ViewController: UIViewController {
    
    private let screenSplit: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.969,
                                       green: 0.808,
                                       blue: 0.498,
                                       alpha: 1)
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstChatView: UITableView = {
        setUpChatView()
    }()
    
    private let secondChatView: UITableView = {
        setUpChatView()
    }()
    
    private let toggleMode: SwitchButton = {
//        let theSwtich = UISwitch()
//        let switchOnImage = UIImage(named: "Sun")
//        let switchOffImage = UIImage(named: "Moon")
//
//        theSwtich.onTintColor = UIColor(red: 0.18,
//                                        green: 0,
//                                        blue: 0.447,
//                                        alpha: 1)
//        theSwtich.thumbTintColor = UIColor(red: 0.624,
//                                           green: 0.376,
//                                           blue: 1,
//                                           alpha: 1)
//        theSwtich.translatesAutoresizingMaskIntoConstraints = false
//        return theSwtich
        let theSwitch = SwitchButton()
        return theSwitch
    }()
    
    private let firstTextField: UITextField = {
        setUpTextField()
    }()
    
    private let firstSendButton: UIButton = {
        setUpButton()
    }()
    
    private let secondTextField: UITextField = {
        setUpTextField()
    }()
    
    private let secondSendButton: UIButton = {
        setUpButton()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        addSubViews()
        setUpConstraints()
        setUpToggle()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            // MARK: Screen Split Constraints
            screenSplit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenSplit.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            screenSplit.widthAnchor.constraint(equalTo: view.widthAnchor),
            screenSplit.heightAnchor.constraint(equalToConstant: 6),
            
            // MARK: Switch Constraints
            toggleMode.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -(view.frame.width * 0.032)),
            toggleMode.topAnchor.constraint(equalTo: view.topAnchor,
                                            constant: view.frame.height * 0.06005),
            toggleMode.widthAnchor.constraint(equalToConstant: 54),
            toggleMode.heightAnchor.constraint(equalToConstant: 27),
            
            // MARK: First Text Field Constraints
            firstTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                  constant: -32),
            firstTextField.bottomAnchor.constraint(equalTo: screenSplit.topAnchor,
                                                   constant: -30),
            firstTextField.heightAnchor.constraint(equalToConstant: 56),
            
            // MARK: First Send Button Constraints
            firstSendButton.bottomAnchor.constraint(equalTo: firstTextField.bottomAnchor,
                                                    constant: -12),
            firstSendButton.trailingAnchor.constraint(equalTo: firstTextField.trailingAnchor,
                                                      constant: -12),
            firstSendButton.topAnchor.constraint(equalTo: firstTextField.topAnchor,
                                                 constant: 12),
            firstSendButton.widthAnchor.constraint(equalToConstant: 32),
            
            // MARK: Second Text Label Constraints
            secondTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondTextField.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                   constant: -32),
            secondTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: -30),
            secondTextField.heightAnchor.constraint(equalToConstant: 56),
            
            // MARK: Second button Constraints
            secondSendButton.bottomAnchor.constraint(equalTo: secondTextField.bottomAnchor,
                                                     constant: -12),
            secondSendButton.trailingAnchor.constraint(equalTo: secondTextField.trailingAnchor,
                                                       constant: -12),
            secondSendButton.topAnchor.constraint(equalTo: secondTextField.topAnchor,
                                                  constant: 12),
            secondSendButton.widthAnchor.constraint(equalToConstant: 32),
            
            // MARK: First Chat View Constraints
            
            firstChatView.topAnchor.constraint(equalTo: toggleMode.bottomAnchor,
                                               constant: 16),
            firstChatView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant:  -16),
            firstChatView.bottomAnchor.constraint(equalTo: firstTextField.topAnchor,
                                                  constant: -25),
            firstChatView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 16),
            
            // MARK: Second Chat View Constraints
            
            secondChatView.topAnchor.constraint(equalTo: screenSplit.bottomAnchor,
                                                constant: 16),
            secondChatView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant:  -16),
            secondChatView.bottomAnchor.constraint(equalTo: secondTextField.topAnchor,
                                                   constant: -25),
            secondChatView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 16)
        ])
    }
    
    private func addSubViews() {
        view.addSubview(screenSplit)
        view.addSubview(toggleMode)
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(firstChatView)
        view.addSubview(secondChatView)
        firstTextField.addSubview(firstSendButton)
        firstTextField.bringSubviewToFront(firstSendButton)
        secondTextField.addSubview(secondSendButton)
        secondTextField.bringSubviewToFront(secondSendButton)
    }
    
    static private func setUpButton() -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor(red: 0.624,
                                                    green: 0.375,
                                                    blue: 1,
                                                    alpha: 1)
        configuration.image = UIImage(named: "Vector")
        configuration.cornerStyle = .capsule
        
        let sendButton = UIButton(configuration: configuration,
                                  primaryAction: nil)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        return sendButton
    }
    
    static private func setUpTextField() -> UITextField{
                let textField = UITextField()
                let paddingView = UIView(frame: CGRect(x: 0
                                                       , y: 0,
                                                       width: 22,
                                                       height: textField.frame.height))
                textField.leftViewMode = .always
                textField.leftView = paddingView
        
                let textColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1)
                let placeHolder = textField.placeholder ?? "დაწერე შეტყობინება..."
                textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: textColor])
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor(red: 0.624,
                                                      green: 0.376,
                                                      blue: 1,
                                                      alpha: 1).cgColor
                textField.layer.cornerRadius = 28
                textField.translatesAutoresizingMaskIntoConstraints = false
        
                return textField
        
    }
    
    private func setUpToggle() {
        toggleMode.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    private static func setUpChatView() -> UITableView{
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    private func setUpUI() {
        firstChatView.delegate = self
        firstChatView.dataSource = self
        secondChatView.dataSource = self
        secondChatView.delegate = self
        
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == firstChatView {
            return 0
        } else if tableView == secondChatView {
            return 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == firstChatView {
            return UITableViewCell()
        } else if tableView == secondChatView {
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    @objc private func switchChanged(_ sender: SwitchButton) {
        let isSwitchOn = sender.status
        if isSwitchOn == true {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.view.backgroundColor = UIColor(red: 0.086,
                                                     green: 0,
                                                     blue: 0.224,
                                                     alpha: 1)
            }
        } else {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.view.backgroundColor = .systemBackground
            }
        }
    }
}
