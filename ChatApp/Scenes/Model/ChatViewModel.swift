//
//  chatViewModel.swift
//  ChatApp
//
//  Created by bakhva  on 20.04.23.
//

import Foundation

final class ChatViewModel {
    
    private (set) var messages = [Message]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView:(() -> ())?
    
    func createMessage(with message: String, senderID: Int32) {
        CoreDataManager.shared.createMessage(with: message, senderID: senderID, date: getDate(), data: &messages)
    }
    
    func getMessage() {
        CoreDataManager.shared.getMessage(data: &messages)
    }
    
    func deleteAllData() {
        CoreDataManager.shared.deleteAllData()
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, H:ss"
        let date = dateFormatter.string(from: Date())
        return date
    }
}
