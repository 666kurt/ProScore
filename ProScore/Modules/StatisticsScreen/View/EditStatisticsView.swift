//
//  EditStatisticsView.swift
//  ProScore
//
//  Created by Максим Шишлов on 23.07.2024.
//

import SwiftUI

struct EditStatisticsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var wins: String = ""
    @State private var losses: String = ""
    @State private var firstPlaces: String = ""
    @State private var players: String = ""
    
    var body: some View {
        VStack {
            SheetTitleView(title: "Editing Dota2 stats")
            
            TextFieldView(title: "Enter quantity of wins",
                          tfText: $wins)
            TextFieldView(title: "Enter quantity of losses",
                          tfText: $losses)
            TextFieldView(title: "Enter number of first places taken",
                          tfText: $firstPlaces)
            TextFieldView(title: "Enter number of of players in team",
                          tfText: $players)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundColor(Color.theme.text.main)
                    .background(Color.theme.other.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
    }
}

#Preview {
    EditStatisticsView()
}
