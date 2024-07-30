// MARK: - SettingsScreen

import SwiftUI

struct SettingsScreen: View {
    
    let persistenceController = PersistenceController.shared
    @State private var showAlert = false
    
    @EnvironmentObject var teamViewModel: TeamViewModel
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    var body: some View {
        
        ZStack {
            VStack {
                TitleView(title: "Settings")
                
                VStack(spacing: 0) {
                    Link(destination: URL(string: "https://www.termsfeed.com/live/f6226db8-c0a0-4b22-b60a-bebb89057d94")!, label: {
                        SettingsCellView(image: "shield.fill", title: "Privacy")
                    })
                    Link(destination: URL(string: "https://www.termsfeed.com/live/17ff4c27-7388-4426-a803-69d88e65fed0")!, label: {
                        SettingsCellView(image: "menucard.fill", title: "Terms of use")
                    })
                    
                }
                
                Spacer()
                
                ButtonView(buttonLabel: "Reset data") {
                    showAlert.toggle()
                }
                .offset(y: -16)
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(
                Color.theme.background.main
                    .ignoresSafeArea()
            )
            
            if showAlert {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                AlertView(showAlert: $showAlert,
                                title: "Reset data",
                                description: "Do you really want to reset the data? It'll cause you to lose progress.", buttonLabel: "Reset",
                                onReset: resetData)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        }
    }
    
    private func resetData() {
        persistenceController.resetData()
        
        teamViewModel.resetData()
        calendarViewModel.resetData()
        statisticsViewModel.resetData()
    }
}

#Preview {
    SettingsScreen()
}
