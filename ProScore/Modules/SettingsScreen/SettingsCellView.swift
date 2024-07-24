//
//  SettingsCellView.swift
//  ProScore
//
//  Created by Максим Шишлов on 24.07.2024.
//

import SwiftUI

struct SettingsCellView: View {
    
    let image: String
    let title: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: image)
                .foregroundColor(Color.theme.other.primary)
            Text(title)
                .foregroundColor(Color.theme.text.main)
                .font(.headline)
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.theme.background.second
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom, 20)
    }
}

#Preview {
    SettingsCellView(image: "bubble.fill", title: "Contact us").padding()
}
