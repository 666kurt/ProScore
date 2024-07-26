import SwiftUI
import CoreData

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
    
    var eventsForSelectedDate: [Event] {
        let calendar = Calendar.current
        return events.filter { event in
            guard let eventDate = event.date else { return false }
            return calendar.isDate(eventDate, inSameDayAs: selectedDate)
        }
    }
    
    func resetData() {
        deleteAllData(for: Event.self)
        fetchEvents()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteAllData<T: NSFetchRequestResult>(for entity: T.Type) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete data for \(entity): \(error.localizedDescription)")
        }
        saveContext()
    }
}
