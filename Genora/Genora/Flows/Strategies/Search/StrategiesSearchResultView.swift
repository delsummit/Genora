//
//  StrategiesSearchResultView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 11/01/2026.
//

import SwiftUI

struct StrategiesSearchResultView: View {
    let pools: [YieldPool]
    
    @State private var sortOption: PoolSortOption = .none
    
    private var sortedPools: [YieldPool] {
        sortOption.sort(pools)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(sortedPools) { pool in
                    
                    StrategiesSearchResultPoolRow(pool: pool)
                        .padding()
                        .background(.backgroundSecondary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
        }
        .navigationTitle("Results (\(pools.count))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    ForEach(PoolSortOption.allCases) { option in
                        Button {
                            sortOption = option
                        } label: {
                            HStack {
                                Text(option.rawValue)
                                if sortOption == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: sortOption.firstIcon)
                        if sortOption != .none {
                            Image(systemName: sortOption.secondIcon)
                                .font(.caption)
                        }
                    }
                    .foregroundStyle(.white)
                }
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbar(.hidden, for: .tabBar)
        .background(.backgroundPrimary)
    }
}

#Preview {
    NavigationStack {
        StrategiesSearchResultView(pools: [
            YieldPool(
                pool: "1",
                chain: "Ethereum",
                project: "Aave",
                symbol: "USDC",
                tvlUsd: 1250000,
                apy: 5.67
            ),
            YieldPool(
                pool: "2",
                chain: "Polygon",
                project: "Uniswap",
                symbol: "ETH-USDT",
                tvlUsd: 3400000,
                apy: 12.34
            ),
            YieldPool(
                pool: "3",
                chain: "Arbitrum",
                project: "Curve",
                symbol: "DAI-USDC-USDT",
                tvlUsd: 8900000,
                apy: 8.92
            )
        ])
    }
}


#Preview("Strategies") {
    MainView()
}
