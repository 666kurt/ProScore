//
//  Router.swift
//  ProScore
//
//  Created by Максим Шишлов on 21.07.2024.
//

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
