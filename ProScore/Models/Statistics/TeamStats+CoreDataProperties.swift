//
//  TeamStats+CoreDataProperties.swift
//  ProScore
//
//  Created by Максим Шишлов on 24.07.2024.
//
//

import Foundation
import CoreData


extension TeamStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamStats> {
        return NSFetchRequest<TeamStats>(entityName: "TeamStats")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var teamName: String?
    @NSManaged public var wins: Int32
    @NSManaged public var losses: Int32
    @NSManaged public var firstPlaces: Int32
    @NSManaged public var players: Int32

}

extension TeamStats : Identifiable {

}
