//
//  TeamViewModel.swift
//  ProScore
//
//  Created by Максим Шишлов on 22.07.2024.
//

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
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            let teams = try context.fetch(fetchRequest)
            if let existingTeam = teams.first {
                existingTeam.name = name
                existingTeam.imageData = image?.pngData()
            } else {
                let newTeam = Team(context: context)
                newTeam.name = name
                newTeam.imageData = image?.pngData()
            }
            try context.save()
        } catch {
            print("Failed to save team: \(error.localizedDescription)")
        }
    }

    func fetchTeam() {
        let fetchRequest: NSFetchRequest<Team> = Team.fetchRequest()
        do {
            let teams = try context.fetch(fetchRequest)
            if let team = teams.first {
                self.name = team.name ?? ""
                if let imageData = team.imageData {
                    self.image = UIImage(data: imageData)
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
            print("Failed to fetch events: \(error.localizedDescription)")
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

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }

}
