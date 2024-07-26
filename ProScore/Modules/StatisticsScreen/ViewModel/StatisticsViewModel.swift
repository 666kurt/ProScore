import SwiftUI
import CoreData

class StatisticsViewModel: ObservableObject {
    @Published var selectedTeam: String = "Dota2"
    @Published var teamStats: [TeamStats] = []
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        fetchStats()
    }
    
    func fetchStats() {
        let request: NSFetchRequest<TeamStats> = TeamStats.fetchRequest()
        do {
            teamStats = try context.fetch(request)
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
    
    func saveStats(wins: Int32, losses: Int32, firstPlaces: Int32, players: Int32) {
        if let existingStats = teamStats.first(where: { $0.teamName == selectedTeam }) {
            existingStats.wins = wins
            existingStats.losses = losses
            existingStats.firstPlaces = firstPlaces
            existingStats.players = players
        } else {
            let newStats = TeamStats(context: context)
            newStats.id = UUID()
            newStats.teamName = selectedTeam
            newStats.wins = wins
            newStats.losses = losses
            newStats.firstPlaces = firstPlaces
            newStats.players = players
        }
        saveContext()
        fetchStats()
    }
    
    func resetData() {
        deleteAllData(for: TeamStats.self)
        fetchStats()
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
