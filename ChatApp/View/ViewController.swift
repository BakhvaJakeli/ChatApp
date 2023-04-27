//
//  ViewController.swift
//  ChatApp
//
//  Created by bakhva  on 19.04.23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Screen Split View
    private let screenSplit: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.yellowViewColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
    // MARK: First Stack View
    private let firstTextFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    // MARK: Second Stack View
    private let secondTextFieldContainer: TextFieldContainerView = {
        let container = TextFieldContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    // MARK: First Chat View
    private let firstChatView: UITableView = {
        setUpChatView()
    }() ///Will add Sender and Receiver Bubble on the cells when building Logic
    
    // MARK: Second Chat View
    private let secondChatView: UITableView = {
        setUpChatView()
    }() ///Will add Sender and Receiver Bubble on the cells when building Logic
    
    // MARK: Toggle Button
    private let toggleMode: UIButton = {
        let theSwtich = UIButton()
        theSwtich.setImage(Constants.Images.lightModeImage, for: .normal)
        theSwtich.translatesAutoresizingMaskIntoConstraints = false
        
        return theSwtich
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
            screenSplit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenSplit.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            screenSplit.widthAnchor.constraint(equalTo: view.widthAnchor),
            screenSplit.heightAnchor.constraint(equalToConstant: 6),
            
            // MARK: Switch Constraints
            toggleMode.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -(view.frame.width * 0.032)),
            toggleMode.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 8),
            toggleMode.widthAnchor.constraint(equalToConstant: 54),
            toggleMode.heightAnchor.constraint(equalToConstant: 27),
            
            // MARK: First Text Field Container Constraints
            firstTextFieldContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstTextFieldContainer.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                           constant: -32),
            firstTextFieldContainer.bottomAnchor.constraint(equalTo: screenSplit.topAnchor,
                                                            constant: -30),
            firstTextFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

            
            // MARK: Second Text Field Constraints
            secondTextFieldContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondTextFieldContainer.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                            constant: -32),
            secondTextFieldContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                             constant: -30),
            secondTextFieldContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            
            // MARK: First Chat View Constraints
            firstChatView.topAnchor.constraint(equalTo: toggleMode.bottomAnchor),
            firstChatView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                    constant:  -16),
            firstChatView.bottomAnchor.constraint(equalTo: firstTextFieldContainer.topAnchor,
                                                  constant: -25),
            firstChatView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 16),
            
            // MARK: Second Chat View Constraints
            secondChatView.topAnchor.constraint(equalTo: screenSplit.bottomAnchor,
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
        [screenSplit, toggleMode, firstChatView, secondChatView, firstTextFieldContainer, secondTextFieldContainer].forEach { [weak self] theView in
            self?.view.addSubview(theView)
        }
    }
    
    // MARK: Chat View Set Up Function
    private static func setUpChatView() -> UITableView{
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
        toggleMode.addTarget(self, action: #selector(switchChanged(_:)), for: .touchUpInside)
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
        
        UIView.transition(with: sender, duration: 0.3, options: [.curveEaseOut, .transitionCrossDissolve], animations: { [weak self] in
            if sender.currentImage == Constants.Images.lightModeImage {
                sender.setImage(Constants.Images.darkModeImage, for: .normal)
                self?.view.backgroundColor = Constants.Colors.darkMode
                self?.screenSplit.backgroundColor = Constants.Colors.darkModeYellowViewColor
                [self?.firstTextFieldContainer, self?.secondTextFieldContainer].forEach { view in
                    [view, view?.textField].forEach { theView in
                        theView?.backgroundColor = Constants.Colors.darkMode
                    }
                    view?.textField.textColor = Constants.Colors.darkModeTextColor
                }
                [self?.firstChatView, self?.secondChatView].forEach { view in
                    view?.backgroundColor = Constants.Colors.darkMode
                }
                
            } else {
                sender.setImage(Constants.Images.lightModeImage, for: .normal)
                self?.view.backgroundColor = .systemBackground
                self?.screenSplit.backgroundColor = Constants.Colors.yellowViewColor
                [self?.firstTextFieldContainer, self?.secondTextFieldContainer].forEach { view in
                    [view, view?.textField].forEach { theView in
                        theView?.backgroundColor = .systemBackground
                    }
                    view?.textField.textColor = Constants.Colors.lightModeTextColor
                }
                [self?.firstChatView, self?.secondChatView].forEach { view in
                    view?.backgroundColor = .systemBackground
                }
                
            }
        }, completion: { _ in
            sender.isEnabled = true
        })
    }
}
