//
//  Participant+CoreDataProperties.swift
//  ProScore
//
//  Created by Максим Шишлов on 23.07.2024.
//
//

import Foundation
import CoreData


extension Participant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Participant> {
        return NSFetchRequest<Participant>(entityName: "Participant")
    }

    @NSManaged public var game: String?
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?

}

extension Participant : Identifiable {

}
