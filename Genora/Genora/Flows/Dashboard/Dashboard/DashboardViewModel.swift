//
//  DashboardViewModel.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 18/12/2025.
//

import Foundation
import Observation

@Observable
@MainActor
final class DashboardViewModel {
    
    // MARK: - State
    var metrics: [MarketOverviewMetric] = []
    var errorMessage: String?
    var isLoading = false
    
    // MARK: - Dependencies
    private let repository: DeFiRepositoryProtocol
    private let calculator: MetricsCalculator
    
    init(
        repository: DeFiRepositoryProtocol,
        calculator: MetricsCalculator
    ) {
        self.repository = repository
        self.calculator = calculator
    }
    
    convenience init() {
        self.init(
            repository: DeFiRepository(),
            calculator: MetricsCalculator()
        )
    }
    
    // MARK: - Public Methods
    func loadMetrics() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let protocols = try await repository.fetchProtocols()
            
            metrics = calculator.calculate(from: protocols)
            
            if metrics.isEmpty {
                errorMessage = "No data available"
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
}
