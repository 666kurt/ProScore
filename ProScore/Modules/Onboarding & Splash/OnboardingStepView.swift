//
//  OnboardingStepView.swift
//  ProScore
//
//  Created by Максим Шишлов on 24.07.2024.
//

import SwiftUI

struct OnboardingStepView: View {
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                
                Image(image)
                    .resizable()
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.title).bold()
                        .foregroundColor(Color.theme.text.main)
                    Text(description)
                        .foregroundColor(Color.theme.background.light)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: geometry.size.height / 4,
                       alignment: .topLeading)
                .padding(.horizontal, 15)
            }
            
        }
    }
}

#Preview {
    OnboardingStepView(image: "onboarding1",
                       title: "Your team",
                       description: "Enter the stats for your team")
}
