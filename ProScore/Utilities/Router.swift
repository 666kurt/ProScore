import Foundation

enum Screens: Hashable {
    case team
    case calendar
    case statistics
    case settings
}

final class Router: ObservableObject {
    
    static let shared = Router()
    private init() {}
    
    @Published var selectedScreen: Screens = .team
    
}
