//
//  DashboardView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 14/12/2025.
//

import SwiftUI

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    MarketOverviewGrid(viewModel: viewModel)
                    
                    TVLChartView()
                }
                .padding()
                .task {
                    await viewModel.loadMetrics()
                }
            }
            .navigationTitle("Market overview")
            .navigationBarTitleDisplayMode(.inline)
            .background(.backgroundPrimary)
        }
    }
}

#Preview {
    DashboardView()
}

