import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TeamModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func resetData() {
        let context = container.viewContext
        let fetchRequests: [NSFetchRequest<NSFetchRequestResult>] = [
            Team.fetchRequest(),
            Participant.fetchRequest(),
            Event.fetchRequest(),
            TeamStats.fetchRequest()
        ]
        
        fetchRequests.forEach { fetchRequest in
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(batchDeleteRequest)
            } catch {
                print("Failed to execute batch delete request: \(error.localizedDescription)")
            }
        }
        
        saveContext()
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


