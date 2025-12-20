//
//  TVLChartViewModel.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 20/12/2025.
//

import Foundation
import Observation

@Observable
@MainActor
final class TVLChartViewModel {
    var historicalData: [HistoricalTVL] = []
    var errorMessage: String?
    var isLoading = false
    
    init() {}
    
    // MARK: - Public Methods
    
    func loadHistoricalTVL() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let data: [HistoricalTVLResponse] = try await APIService.shared.fetchChains(
                endpoint: HistoricalTVL.endpoint
            )
            
            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
            
            historicalData = data
                .filter { item in
                    let itemDate = Date(timeIntervalSince1970: TimeInterval(item.date))
                    return itemDate >= oneWeekAgo
                }
                .enumerated()
                .map { index, item in
                    HistoricalTVL(
                        id: "\(item.date)",
                        date: item.date,
                        tvl: Int(item.tvl)
                    )
                }
        } catch LiamaAPIError.invalidURL {
            errorMessage = "Invalid URL"
        } catch LiamaAPIError.invalidResponse {
            errorMessage = "Invalid response"
        } catch LiamaAPIError.invalidData {
            errorMessage = "Invalid data"
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // MARK: - Computed Properties
    
    var minTVL: Int {
        historicalData.map(\.tvl).min() ?? 0
    }
    
    var maxTVL: Int {
        historicalData.map(\.tvl).max() ?? 0
    }
    
    var currentTVL: Int {
        historicalData.last?.tvl ?? 0
    }
    
    var tvlChange: Double {
        guard historicalData.count >= 2,
              let first = historicalData.first?.tvl,
              first > 0 else {
            return 0
        }
        
        let last = historicalData.last?.tvl ?? 0
        return ((Double(last) - Double(first)) / Double(first)) * 100
    }
}
