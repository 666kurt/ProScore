//
//  TextFieldView.swift
//  ProScore
//
//  Created by Максим Шишлов on 22.07.2024.
//

import SwiftUI

struct TextFieldView: View {
    
    let title: String
    @Binding var tfText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if tfText.isEmpty {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color.theme.background.light)
            }
            TextField("", text: $tfText)
        }
        .padding()
        .background(Color.theme.background.second)
        .foregroundColor(Color.theme.text.main)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.theme.background.light, lineWidth: 1)
        )
        .padding(.bottom, 20)
    }
}

#Preview {
    TextFieldView(title: "Enter the name", tfText: .constant(""))
        .padding()
}
