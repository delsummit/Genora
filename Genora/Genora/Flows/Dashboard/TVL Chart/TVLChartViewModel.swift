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
    
    // MARK: - State
    
    var historicalData: [HistoricalTVL] = []
    var stats: TVLStats = TVLStats(min: 0, max: 0, current: 0, change: 0)
    var errorMessage: String?
    var isLoading = false
    
    // MARK: - Dependencies
    
    private let repository: DeFiRepositoryProtocol
    private let processor: HistoricalTVLProcessor
    
    init(
        repository: DeFiRepositoryProtocol,
        processor: HistoricalTVLProcessor
    ) {
        self.repository = repository
        self.processor = processor
    }
    
    convenience init() {
        self.init(
            repository: DeFiRepository(),
            processor: HistoricalTVLProcessor()
        )
    }
    
    // MARK: - Public Methods
    
    func loadHistoricalTVL() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let rawData = try await repository.fetchHistoricalTVL()
            
            historicalData = processor.process(rawData, days: 14)
            stats = processor.calculateStats(from: historicalData)
            
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
}
