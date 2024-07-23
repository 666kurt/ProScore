//
//  Event+CoreDataProperties.swift
//  ProScore
//
//  Created by Максим Шишлов on 23.07.2024.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var startTime: Date?

}

extension Event : Identifiable {

}
