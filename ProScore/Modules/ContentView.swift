import SwiftUI

struct ContentView: View {
    @StateObject var router = Router.shared
    @StateObject var teamViewModel = TeamViewModel()
    @StateObject var calendarViewModel = CalendarViewModel()
    @StateObject var statisticsViewModel = StatisticsViewModel()
    
    @StateObject var webViewModel: WebViewModel

    var body: some View {
        ZStack {
            TabView(selection: $router.selectedScreen) {
                TeamScreen()
                    .tabItem {
                        Label("Team", systemImage: "person.2.fill")
                    }
                    .tag(Screens.team)
                    .environmentObject(teamViewModel)

                CalendarScreen()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                    .tag(Screens.calendar)
                    .environmentObject(calendarViewModel)

                StatisticsScreen()
                    .tabItem {
                        Label("Statistics", systemImage: "chart.line.uptrend.xyaxis")
                    }
                    .tag(Screens.statistics)
                    .environmentObject(statisticsViewModel)

                SettingsScreen()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    .tag(Screens.settings)
                    .environmentObject(teamViewModel)
                    .environmentObject(calendarViewModel)
                    .environmentObject(statisticsViewModel)
            }
            .accentColor(Color.theme.text.main)
            .onAppear(perform: setupTabBarAppearance)
            .onAppear {
                webViewModel.fetchConfig() // Запуск запроса конфигурации при загрузке
            }
            
            // Отображение WebView
            if webViewModel.showWebView, let url = webViewModel.url {
                WebView(url: url)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.theme.other.tabbar)
        appearance.shadowColor = UIColor(Color.white.opacity(0.15))
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.background.light)
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    ContentView(webViewModel: WebViewModel(appDelegate: AppDelegate()))
        .environmentObject(Router.shared)
        .environmentObject(TeamViewModel())
        .environmentObject(CalendarViewModel())
        .environmentObject(StatisticsViewModel())
}
