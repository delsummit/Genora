//
//  BlockchainChain.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 06/01/2026.
//

import SwiftUI

struct ChainConfig {
    let name: String
    let trustWalletPath: String
    let iconName: String
    let apiNames: [String]
    
    init(_ name: String, tw: String? = nil, icon: String? = nil, api: [String]? = nil) {
        self.name = name
        self.trustWalletPath = tw ?? name.lowercased()
        self.iconName = icon ?? "\(name.prefix(1).lowercased()).circle.fill"
        self.apiNames = api ?? [name]
    }
}

enum BlockchainChain: String, CaseIterable, Identifiable {
    case ethereum = "Ethereum"
    case binance = "Binance"
    case polygon = "Polygon"
    case arbitrum = "Arbitrum"
    case optimism = "Optimism"
    case avalanche = "Avalanche"
    case fantom = "Fantom"
    case solana = "Solana"
    case base = "Base"
    case linea = "Linea"
    
    var id: String { rawValue }
    
    // tw - trust wallet, icon - placeholder
    private static let configs: [BlockchainChain: ChainConfig] = [
        .ethereum:  ChainConfig("Ethereum", tw: "ethereum", icon: "e.circle.fill", api: ["Ethereum"]),
        .binance:   ChainConfig("Binance", tw: "smartchain", icon: "b.circle.fill", api: ["Binance", "BSC"]),
        .polygon:   ChainConfig("Polygon", tw: "polygon", icon: "p.circle.fill", api: ["Polygon"]),
        .arbitrum:  ChainConfig("Arbitrum", tw: "arbitrum", icon: "a.circle.fill", api: ["Arbitrum"]),
        .optimism:  ChainConfig("Optimism", tw: "optimism", icon: "o.circle.fill", api: ["Optimism"]),
        .avalanche: ChainConfig("Avalanche", tw: "avalanchec", icon: "a.circle.fill", api: ["Avalanche"]),
        .fantom:    ChainConfig("Fantom", tw: "fantom", icon: "f.circle.fill", api: ["Fantom"]),
        .solana:    ChainConfig("Solana", tw: "solana", icon: "s.circle.fill", api: ["Solana"]),
        .base:      ChainConfig("Base", tw: "base", icon: "b.circle.fill", api: ["Base"]),
        .linea:     ChainConfig("Linea", tw: "linea", icon: "l.circle.fill", api: ["Linea"]),
    ]
    
    private var config: ChainConfig {
        Self.configs[self]!
    }
    
    var trustWalletIconURL: URL? {
        let baseURL = "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains"
        return URL(string: "\(baseURL)/\(config.trustWalletPath)/info/logo.png")
    }
    
    // placeholder
    var iconName: String {
        config.iconName
    }
    
    var color: Color {
        return .accentColor
    }
    
    // MARK: - for DefiLlama API
    
    var apiChainNames: [String] {
        config.apiNames
    }
    
    func matches(apiChainName: String) -> Bool {
        return apiChainNames.contains(apiChainName)
    }
}

extension BlockchainChain: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
    
    static func == (lhs: BlockchainChain, rhs: BlockchainChain) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
