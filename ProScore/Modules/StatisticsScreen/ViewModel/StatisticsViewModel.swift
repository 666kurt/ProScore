import SwiftUI
import CoreData

class StatisticsViewModel: ObservableObject {
    @Published var selectedTeam: String = "Dota2"
    @Published var teamStats: [TeamStats] = []
    let context = PersistenceController.shared.container.viewContext
    
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
        
        do {
            try context.save()
            fetchStats()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func resetData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TeamStats.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to reset data: \(error.localizedDescription)")
        }
        fetchStats()
    }
}
