//
//  ContentView.swift
//  ProScore
//
//  Created by Максим Шишлов on 21.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router.shared
    
    var body: some View {
        
        TabView(selection: $router.selectedScreen) {
            TeamScreen()
                .tabItem {
                    Label("Team", systemImage: "person.2.fill")
                }.tag(Screens.team)
            CalendarScreen()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }.tag(Screens.calendar)
            Text("StatisticScreen")
                .tabItem {
                    Label("Statistics", systemImage: "chart.line.uptrend.xyaxis")
                }.tag(Screens.statistics)
            Text("SettingsScreen")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(Screens.settings)
        }
        .accentColor(Color.theme.text.main)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.background.light)
            UITabBar.appearance().backgroundColor = UIColor(Color.theme.other.tabbar)
            
            let transparentAppearence = UITabBarAppearance()
            transparentAppearence.configureWithTransparentBackground()
            UITabBar.appearance().standardAppearance = transparentAppearence
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(Router.shared)
}
