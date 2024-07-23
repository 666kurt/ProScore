//
//  ProScoreApp.swift
//  ProScore
//
//  Created by Максим Шишлов on 19.07.2024.
//

import SwiftUI

@main
struct ProScoreApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
