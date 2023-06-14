//
//  Message+CoreDataProperties.swift
//  ChatApp
//
//  Created by bakhva  on 19.05.23.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var dateSent: String?
    @NSManaged public var senderID: Int32
    @NSManaged public var text: String?

}

extension Message : Identifiable {

}
