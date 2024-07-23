//
//  TeamListView.swift
//  ProScore
//
//  Created by Максим Шишлов on 22.07.2024.
//

import SwiftUI

struct TeamListView: View {
    
    @ObservedObject var viewModel: TeamViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var nickname: String = ""
    @State var game: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background.main
                .ignoresSafeArea()
            
            VStack {
                SheetTitleView(title: "Add participants")
                
                TextFieldView(title: "Enter name", tfText: $name)
                TextFieldView(title: "Enter nickname", tfText: $nickname)
                TextFieldView(title: "Enter game", tfText: $game)
                
                Button {
                    viewModel.addParticipant(
                        name: name,
                        nickname: nickname,
                        game: game)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundColor(Color.theme.text.main)
                        .background(
                            (name.isEmpty
                             || nickname.isEmpty
                             || game.isEmpty)
                            ? Color.theme.background.light
                            : Color.theme.other.primary
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    TeamListView(viewModel: TeamViewModel())
}
