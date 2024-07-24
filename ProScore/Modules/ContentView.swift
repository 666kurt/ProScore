import SwiftUI

struct ContentView: View {
    
    @StateObject var router = Router.shared
    
    @StateObject var teamViewModel = TeamViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()
    @StateObject var statisticsViewModel = StatisticsViewModel()
    
    var body: some View {
        
        TabView(selection: $router.selectedScreen) {
            TeamScreen()
                .tabItem {
                    Label("Team", systemImage: "person.2.fill")
                }.tag(Screens.team)
                .environmentObject(teamViewModel)
            CalendarScreen()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }.tag(Screens.calendar)
                .environmentObject(calendarViewModel)
            StatisticsScreen()
                .tabItem {
                    Label("Statistics", systemImage: "chart.line.uptrend.xyaxis")
                }.tag(Screens.statistics)
                .environmentObject(statisticsViewModel)
            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(Screens.settings)
                .environmentObject(teamViewModel)
                .environmentObject(calendarViewModel)
                .environmentObject(statisticsViewModel)
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
        .environmentObject(TeamViewModel())
        .environmentObject(CalendarViewModel())
        .environmentObject(StatisticsViewModel())
}
