//
//  StatisticsScreen.swift
//  ProScore
//
//  Created by Максим Шишлов on 23.07.2024.
//

import SwiftUI

struct StatisticsScreen: View {
    
    @State private var showEditStatistics = false
    
    var body: some View {
        VStack {
            
            TitleView(title: "Statistics")
            
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
            EditStatisticsView()
        }
    }
}

extension StatisticsScreen {
    
    private var statisticsCellsView: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                StatisticsCellView(title: "Test", value: 0)
                StatisticsCellView(title: "Test", value: 0)
            }
            StatisticsCellView(title: "Test", value: 0)
            StatisticsCellView(title: "Test", value: 0)
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
}
