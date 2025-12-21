//
//  DeFiRepository.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 21/12/2025.
//

import Foundation

protocol DeFiRepositoryProtocol {
    func fetchProtocols() async throws -> [ProtocolsTVL]
    func fetchHistoricalTVL() async throws -> [HistoricalTVLResponse]
}

final class DeFiRepository: DeFiRepositoryProtocol {
    
    private let apiService: APIService
    
    init(apiService: APIService = .shared) {
        self.apiService = apiService
    }
    
    func fetchProtocols() async throws -> [ProtocolsTVL] {
        try await apiService.fetchChains(endpoint: ProtocolsTVL.endpoint)
    }
    
    func fetchHistoricalTVL() async throws -> [HistoricalTVLResponse] {
        try await apiService.fetchChains(endpoint: HistoricalTVL.endpoint)
    }
}

// MARK: - Mock Repository

final class MockDeFiRepository: DeFiRepositoryProtocol {
    
    var shouldFail = false
    var mockProtocols: [ProtocolsTVL] = []
    var mockHistoricalData: [HistoricalTVLResponse] = []
    
    func fetchProtocols() async throws -> [ProtocolsTVL] {
        if shouldFail {
            throw LiamaAPIError.invalidData
        }
        
        if mockProtocols.isEmpty {
            return Self.sampleProtocols
        }
        
        return mockProtocols
    }
    
    func fetchHistoricalTVL() async throws -> [HistoricalTVLResponse] {
        if shouldFail {
            throw LiamaAPIError.invalidData
        }
        
        if mockHistoricalData.isEmpty {
            return Self.sampleHistoricalData
        }
        
        return mockHistoricalData
    }
    
    // MARK: - Mock
    
    static let sampleProtocols: [ProtocolsTVL] = [
        ProtocolsTVL(
            id: "1",
            name: "Aave",
            symbol: "AAVE",
            category: "Lending",
            chains: ["Ethereum", "Polygon"],
            tvl: 5_000_000_000,
            chainTvls: ["Ethereum": 4_000_000_000, "Polygon": 1_000_000_000],
            change_1d: 2.5,
            change_7d: 5.2
        ),
        ProtocolsTVL(
            id: "2",
            name: "Uniswap",
            symbol: "UNI",
            category: "Dexes",
            chains: ["Ethereum"],
            tvl: 3_500_000_000,
            chainTvls: ["Ethereum": 3_500_000_000],
            change_1d: -1.2,
            change_7d: 3.4
        )
    ]
    
    static let sampleHistoricalData: [HistoricalTVLResponse] = {
        let now = Date()
        return (0..<7).map { dayOffset in
            let date = Calendar.current.date(byAdding: .day, value: -dayOffset, to: now)!
            let timestamp = Int(date.timeIntervalSince1970)
            let tvl = 50_000_000_000.0 + Double(dayOffset) * 1_000_000_000.0
            return HistoricalTVLResponse(date: timestamp, tvl: tvl)
        }
    }()
}

// MARK: - ProtocolsTVL Initializer

extension ProtocolsTVL {
    init(id: String, name: String, symbol: String?, category: String?, chains: [String]?, tvl: Double?, chainTvls: [String: Double]?, change_1d: Double?, change_7d: Double?) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.category = category
        self.chains = chains
        self.tvl = tvl
        self.chainTvls = chainTvls
        self.change_1d = change_1d
        self.change_7d = change_7d
    }
}
