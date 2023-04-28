//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: Screen Split View
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellowViewColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
    // MARK: First Text Field View
    private let firstTextFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.textField.font = .systemFont(ofSize: 14)

        return container
    }()
    
    // MARK: Second Text Field View
    private let secondTextFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.textField.font = .systemFont(ofSize: 14)

        return container
    }()
    
    // MARK: First Chat View
    //Will add Sender and Receiver Bubble on the cells when building Logic
    private let firstChatView: UITableView = {
        makeChatVIew()
    }()
    
    // MARK: Second Chat View
    //Will add Sender and Receiver Bubble on the cells when building Logic
    private let secondChatView: UITableView = {
        makeChatVIew()
    }()
    
    // MARK: Toggle Button
    private let switcherButton: UIButton = {
        let swtich = UIButton()
        swtich.setImage(UIImageView.lightModeImage, for: .normal)
        swtich.translatesAutoresizingMaskIntoConstraints = false
        
        return swtich
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        addSubViews()
        setUpConstraints()
    }
    
    //MARK: Setting Up Constratins
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            // MARK: Screen Split Constraints
            dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dividerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 6),
            
            // MARK: Switch Constraints
            switcherButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -(view.frame.width * 0.032)),
            switcherButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 8),
            switcherButton.widthAnchor.constraint(equalToConstant: 54),
            switcherButton.heightAnchor.constraint(equalToConstant: 27),
            
            // MARK: First Text Field Container Constraints
            firstTextFieldContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstTextFieldContainer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                                           constant: -32),
            firstTextFieldContainer.bottomAnchor.constraint(equalTo: dividerView.topAnchor,
                                                            constant: -30),
            firstTextFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),

            
            // MARK: Second Text Field Constraints
            secondTextFieldContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondTextFieldContainer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,
                                                            constant: -32),
            secondTextFieldContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                             constant: -30),
            secondTextFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),
            
            
            // MARK: First Chat View Constraints
            firstChatView.topAnchor.constraint(equalTo: switcherButton.bottomAnchor),
            firstChatView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant:  -16),
            firstChatView.bottomAnchor.constraint(equalTo: firstTextFieldContainer.topAnchor,
                                                  constant: -25),
            firstChatView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 16),
            
            // MARK: Second Chat View Constraints
            secondChatView.topAnchor.constraint(equalTo: dividerView.bottomAnchor,
                                                constant: 16),
            secondChatView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant:  -16),
            secondChatView.bottomAnchor.constraint(equalTo: secondTextFieldContainer.topAnchor,
                                                   constant: -25),
            secondChatView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: 16)
        ])
    }
    
    // MARK: Adding SubViews
    private func addSubViews() {
        [dividerView, switcherButton, firstChatView, secondChatView, firstTextFieldContainer, secondTextFieldContainer].forEach { [weak self] theView in
            self?.view.addSubview(theView)
        }
    }
    
    // MARK: Chat View Set Up Function
    private static func makeChatVIew() -> UITableView{
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }
    
    // MARK: UI Set Up
    private func setUpUI() {
        [firstChatView, secondChatView].forEach { [weak self] tableView in
            tableView.delegate = self
            tableView.dataSource = self
        }
        switcherButton.addTarget(self, action: #selector(switchChanged(_:)), for: .touchUpInside)
    }
}

// MARK: Table View Functions
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
    
}

// MARK: Obj C Functions
extension ViewController {
    
    @objc private func switchChanged(_ sender: UIButton) {
        sender.isEnabled = false
        
        UIView.transition(with: sender, duration: 0.3, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
    
            if sender.currentImage == UIImageView.darkModeImage {
                self.setUpViewsForDarkMode(sender)
            } else {
                self.setUpViewsForLightMode(sender)
            }
        }, completion: { _ in
            sender.isEnabled = true
        })
    }
    
    private func setUpViewsForDarkMode(_ button: UIButton) {
        button.setImage(UIImageView.darkModeImage, for: .normal)
        view.backgroundColor = .backgroundDarkModeColor
        dividerView.backgroundColor = .darkModeYellowViewColor
        [firstTextFieldContainer, secondTextFieldContainer].forEach { view in
            [view, view.textField].forEach { theView in
                theView?.backgroundColor = .backgroundDarkModeColor
            }
            view.textField.textColor = .darkModeTextColor
        }
        [firstChatView, secondChatView].forEach { view in
            view?.backgroundColor = .backgroundDarkModeColor
        }
    }
    
    private func setUpViewsForLightMode(_ button: UIButton) {
        button.setImage(UIImageView.lightModeImage, for: .normal)
        view.backgroundColor = .systemBackground
        dividerView.backgroundColor = .yellowViewColor
        [firstTextFieldContainer, secondTextFieldContainer].forEach { view in
            [view, view.textField].forEach { theView in
                theView?.backgroundColor = .systemBackground
            }
            view.textField.textColor = .lightModeTextColor
        }
        [firstChatView,secondChatView].forEach { view in
            view?.backgroundColor = .systemBackground
        }
    }
}
