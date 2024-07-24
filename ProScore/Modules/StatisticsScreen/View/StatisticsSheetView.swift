import SwiftUI

struct StatisticsSheetView: View {
    
    @ObservedObject var viewModel: StatisticsViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var wins: String = ""
    @State private var losses: String = ""
    @State private var firstPlaces: String = ""
    @State private var players: String = ""
    
    var body: some View {
        VStack {
            SheetTitleView(title: "Editing \(viewModel.selectedTeam) stats")
            
            TextFieldView(title: "Enter quantity of wins",
                          tfText: $wins)
            TextFieldView(title: "Enter quantity of losses",
                          tfText: $losses)
            TextFieldView(title: "Enter number of first places taken",
                          tfText: $firstPlaces)
            TextFieldView(title: "Enter number of of players in team",
                          tfText: $players)
            
            Button {
                if let wins = Int32(wins), let losses = Int32(losses), let firstPlaces = Int32(firstPlaces), let players = Int32(players) {
                    viewModel.saveStats(wins: wins, losses: losses, firstPlaces: firstPlaces, players: players)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("Add")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundColor(textColor)
                    .background(buttonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(!buttonIsValid)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
        .onAppear {
            if let existingStats = viewModel.teamStats.first(where: { $0.teamName == viewModel.selectedTeam }) {
                wins = String(existingStats.wins)
                losses = String(existingStats.losses)
                firstPlaces = String(existingStats.firstPlaces)
                players = String(existingStats.players)
            }
        }
    }
    
    private var buttonIsValid: Bool {
        return !wins.isEmpty && !losses.isEmpty
        && !firstPlaces.isEmpty && !players.isEmpty
    }

    private var buttonColor: Color {
        return buttonIsValid ? Color.theme.other.primary : Color.theme.other.disabled
    }
    
    private var textColor: Color {
        return buttonIsValid ? Color.theme.text.main : Color.theme.background.light
    }
}

#Preview {
    StatisticsSheetView(viewModel: StatisticsViewModel())
}
