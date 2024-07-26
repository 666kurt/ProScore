// MARK: - StatisticsScreen

import SwiftUI

struct StatisticsScreen: View {
    
    @EnvironmentObject private var viewModel: StatisticsViewModel
    @State private var showEditStatistics = false
    
    var body: some View {
        VStack {
            TitleView(title: "Statistics")
            gamePickerView
            statisticsCellsView
            editButtonView        
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
        .sheet(isPresented: $showEditStatistics) {
            StatisticsSheetView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.fetchStats()
        }
    }
}

// MARK: - StatisticsScreen's components

extension StatisticsScreen {
    
    private var gamePickerView: some View {
        Picker("Select Team", selection: $viewModel.selectedTeam) {
            Text("Dota2").tag("Dota2")
            Text("LoL").tag("LoL")
        }
        .padding(2)
        .background(Color.theme.background.second)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .pickerStyle(.segmented)
        .padding(.bottom, 28)
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.other.primary)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.text.main), .font: UIFont.boldSystemFont(ofSize: 13)], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.text.main), .font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        }
    }
    
    private var statisticsCellsView: some View {
        VStack(spacing: 15) {
            let stats = viewModel.teamStats.first(where: { $0.teamName == viewModel.selectedTeam })
            HStack(spacing: 15) {
                StatisticsCellView(title: "Quantity of wins", value: Int(stats?.wins ?? 0))
                StatisticsCellView(title: "Quantity of losses", value: Int(stats?.losses ?? 0))
            }
            StatisticsCellView(title: "Number of first places taken", value: Int(stats?.firstPlaces ?? 0))
            StatisticsCellView(title: "Number of players in team", value: Int(stats?.players ?? 0))
        }
    }
    
    private var editButtonView: some View {
        Button {
            showEditStatistics.toggle()
        } label: {
            Text("Edit")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .foregroundColor(Color.theme.text.main)
                .background(Color.theme.other.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.top, 10)
    }
    
}

#Preview {
    StatisticsScreen()
        .environmentObject(StatisticsViewModel())
}
