import SwiftUI
import OneSignalFramework
import ApphudSDK
import AppMetricaCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_v1NiMZzYu1UMJEs5YLM9JhoCHdZGs8")
        
        OneSignal.initialize("303253bd-57d4-423c-9536-831b573d8c69", withLaunchOptions: launchOptions)
        OneSignal.login(Apphud.userID())
        
        let configuration = AppMetricaConfiguration(apiKey: "f0174b9e-6837-480e-b512-57ac0ab60aa1")
        AppMetrica.activate(with: configuration!)
        
        return true
    }
}

@main
struct ProScoreApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false
    
    var body: some Scene {
        WindowGroup {
            SplashScreen(showOnboarding: $showOnboarding, persistenceController: persistenceController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
