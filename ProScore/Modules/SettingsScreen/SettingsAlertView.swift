//
//  SettingsAlertView.swift
//  ProScore
//
//  Created by Максим Шишлов on 24.07.2024.
//

import SwiftUI

struct SettingsAlertView: View {
    
    @Binding var showAlert: Bool
    var onReset: () -> Void
    
    var body: some View {
            VStack(spacing: 0) {
                Text("Reset data")
                    .font(.headline)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                Text("Do you really want to reset the data? It'll cause you to lose progress.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                
                Divider()
                    .background(Color(hex: "#545458"))
                
                HStack {
                    
                    Button {
                        showAlert = false
                    } label: {
                        Text("Close")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    
                    Divider()
                        .background(Color(hex: "#545458"))
                    
                    Button {
                        onReset()
                        showAlert = false
                    } label: {
                        Text("Reset")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.theme.other.primary)
                        
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
            }
            .foregroundColor(Color.theme.text.main)
            .zIndex(1)
            .frame(maxWidth: 270, alignment: .center)
            .background(
                Color.theme.background.second
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    SettingsAlertView(showAlert: .constant(true)) {
        //
    }
}
