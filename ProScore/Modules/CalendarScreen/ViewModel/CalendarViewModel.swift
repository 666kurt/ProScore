//
//  CalendarViewModel.swift
//  ProScore
//
//  Created by Максим Шишлов on 23.07.2024.
//

import Foundation
import CoreData
import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedDate: Date = Date()
    
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        fetchEvents()
    }
    
    func fetchEvents() {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        do {
            events = try context.fetch(request)
        } catch {
            print("Failed to fetch events: \(error.localizedDescription)")
        }
    }
    
    func addEvent(name: String, date: Date, startTime: Date) {
        let newEvent = Event(context: context)
        newEvent.name = name
        newEvent.date = date
        newEvent.startTime = startTime
        saveContext()
        fetchEvents()
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }
    
    func resetData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Event.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to reset data: \(error.localizedDescription)")
        }
        fetchEvents()
    }
}

