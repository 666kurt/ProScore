//
//  TeamHeaderView.swift
//  ProScore
//
//  Created by Максим Шишлов on 22.07.2024.
//

import SwiftUI

struct TeamHeaderView: View {
    
    @ObservedObject var viewModel: TeamViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.theme.background.main
                .ignoresSafeArea()
            
            VStack {
                SheetTitleView(title: "Add the info")
                
                Button(action: {
                    viewModel.isImagePickerPresented = true
                }) {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.theme.background.second)
                            .frame(width: 160, height: 140)
                            .overlay(Image(systemName: "camera.fill").foregroundColor(.white))
                    }
                }
                
                TextFieldView(title: "Enter name", tfText: $viewModel.name)
                
                Button {
                    viewModel.saveTeam()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundColor(Color.theme.text.main)
                        .background(
                            (viewModel.name.isEmpty || viewModel.image == nil)
                            ? Color.theme.background.light
                            : Color.theme.other.primary
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(image: $viewModel.image)
        }
    }
}

#Preview {
    TeamHeaderView(viewModel: TeamViewModel())
}
