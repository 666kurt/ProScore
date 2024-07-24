import SwiftUI

@main
struct ProScoreApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @State private var showSplashScreen = true
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false
    
    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                OnboardingScreen(showOnboarding: $showOnboarding)
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
