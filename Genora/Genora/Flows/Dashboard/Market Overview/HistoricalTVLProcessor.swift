//
//  HistoricalTVLProcessor.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 21/12/2025.
//

import Foundation

struct HistoricalTVLProcessor {
    
    func process(_ rawData: [HistoricalTVLResponse], days: Int = 7) -> [HistoricalTVL] {
        let cutoffDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        
        return rawData
            .filter { item in
                let itemDate = Date(timeIntervalSince1970: TimeInterval(item.date))
                return itemDate >= cutoffDate
            }
            .map { item in
                HistoricalTVL(
                    id: "\(item.date)",
                    date: item.date,
                    tvl: Int(item.tvl)
                )
            }
            .sorted { $0.date < $1.date }
    }
    
    func calculateStats(from data: [HistoricalTVL]) -> TVLStats {
        guard !data.isEmpty else {
            return TVLStats(min: 0, max: 0, current: 0, change: 0)
        }
        
        let min = data.map(\.tvl).min() ?? 0
        let max = data.map(\.tvl).max() ?? 0
        let current = data.last?.tvl ?? 0
        
        let change = calculateChange(from: data)
        
        return TVLStats(min: min, max: max, current: current, change: change)
    }
    
    // MARK: - Private
    
    private func calculateChange(from data: [HistoricalTVL]) -> Double {
        guard data.count >= 2,
              let first = data.first?.tvl,
              first > 0 else {
            return 0
        }
        
        let last = data.last?.tvl ?? 0
        return ((Double(last) - Double(first)) / Double(first)) * 100
    }
}

// MARK: - Stats Model

struct TVLStats {
    let min: Int
    let max: Int
    let current: Int
    let change: Double
}
