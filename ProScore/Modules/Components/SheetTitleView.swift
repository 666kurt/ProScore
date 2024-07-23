//
//  SheetTitleView.swift
//  ProScore
//
//  Created by Максим Шишлов on 23.07.2024.
//

import SwiftUI

struct SheetTitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Color.theme.text.main)
            .padding(.vertical, 20)
    }
}

#Preview {
    SheetTitleView(title: "Test title")
}
