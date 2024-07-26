import SwiftUI
import CoreData

class TeamViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var image: UIImage? = nil
    @Published var participant: [Participant] = []
    @Published var isImagePickerPresented: Bool = false
    
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        fetchTeam()
        fetchParticipant()
    }
    
    func saveTeam() {
        do {
            let team = try fetchSingleTeam() ?? Team(context: context)
            team.name = name
            team.imageData = image?.pngData()
            try context.save()
        } catch {
            print("Failed to save team: \(error.localizedDescription)")
        }
    }
    
    func fetchTeam() {
        do {
            if let team = try fetchSingleTeam() {
                name = team.name ?? ""
                if let imageData = team.imageData {
                    image = UIImage(data: imageData)
                }
            }
        } catch {
            print("Failed to fetch team: \(error.localizedDescription)")
        }
    }
    
    func fetchParticipant() {
        let request: NSFetchRequest<Participant> = Participant.fetchRequest()
        do {
            participant = try context.fetch(request)
        } catch {
            print("Failed to fetch participants: \(error.localizedDescription)")
        }
    }
    
    func addParticipant(name: String, nickname: String, game: String) {
        let newGamer = Participant(context: context)
        newGamer.name = name
        newGamer.nickname = nickname
        newGamer.game = game
        saveContext()
        fetchParticipant()
    }
    
    func deleteParticipant(at offsets: IndexSet) {
        offsets.forEach { index in
            let participantToDelete = participant[index]
            context.delete(participantToDelete)
        }
        saveContext()
        fetchParticipant()
    }
    
    func resetData() {
        deleteAllData(for: Team.self)
        deleteAllData(for: Participant.self)
        name = ""
        image = nil
        participant.removeAll()
    }
    
    private func fetchSingleTeam() throws -> Team? {
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        fetchRequest.fetchLimit = 1
        let teams = try context.fetch(fetchRequest)
        return teams.first
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
