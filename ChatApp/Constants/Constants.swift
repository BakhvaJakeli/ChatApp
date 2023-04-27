//
//  Constants.swift
//  ChatApp
//
//  Created by bakhva  on 26.04.23.
//

import UIKit

struct Constants {
    
    // MARK: Color Constants
    struct Colors {
        static let darkMode = UIColor(red: 0.086,
                                      green: 0,
                                      blue: 0.224,
                                      alpha: 1)
        static let yellowViewColor = UIColor(red: 0.969,
                                             green: 0.808,
                                             blue: 0.498,
                                             alpha: 1)
        static let darkModeYellowViewColor = UIColor(red: 1,
                                                     green: 0.792,
                                                     blue: 0.333,
                                                     alpha: 1)
        static let borderColor = UIColor(red: 0.624,
                                         green: 0.376,
                                         blue: 1,
                                         alpha: 1)
        static let sendButtonCollor = UIColor(red: 0.624,
                                              green: 0.375,
                                              blue: 1,
                                              alpha: 1)
        static let lightModeTextColor = UIColor(red: 0.098,
                                                green: 0.098,
                                                blue: 0.098,
                                                alpha: 1)
        static let darkModeTextColor = UIColor(red: 0.945,
                                               green: 0.945,
                                               blue: 0.945,
                                               alpha: 1)
    }
    
    // MARK: Image constants
    struct Images {
        static let lightModeImage = UIImage(named: "Light_Mode")
        static let darkModeImage =  UIImage(named: "Dark_Mode")
        static let sendButtomImmage = UIImage(named: "Vector")
    }
}
