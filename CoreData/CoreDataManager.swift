//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by bakhva  on 18.05.23.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    func createMessage(with message: String, senderID: Int32, date: String, data: inout[Message]) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let newMessage = Message(context: managedContext)
        if NetworkMonitor.shared.isConnected {
            newMessage.setValue(date, forKey: #keyPath(Message.dateSent))
        }
        else {
            newMessage.setValue(ErrorMessage.errorMessage, forKey: #keyPath(Message.dateSent))
        }
        newMessage.setValue(message, forKey: #keyPath(Message.text))
        newMessage.setValue(senderID, forKey: "senderID")
        data.append(newMessage)
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
    
    func getMessage(data: inout[Message]) {
        let messageFetch: NSFetchRequest<Message> = Message.fetchRequest()
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try managedContext.fetch(messageFetch)
            data = results
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllData() {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        let deleteAllData = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Message"))
        do {
            try managedContext.execute(deleteAllData)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
