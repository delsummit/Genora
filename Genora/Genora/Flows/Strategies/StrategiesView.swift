//
//  StrategiesView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 14/12/2025.
//

import SwiftUI

struct StrategiesView: View {
    @State private var usdtAmount: Double?
    @FocusState private var isAmountFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Amount you want to invest")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        
                        HStack {
                            Image("usdtLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text("USDT")
                                .foregroundStyle(.secondary)
                                .bold()
                            
                            Rectangle()
                                .fill(.tertiary)
                                .frame(width: 1)
                            
                            TextField("0.00", value: $usdtAmount, format: .number.grouping(.automatic))
                                .textFieldStyle(.plain)
                                .keyboardType(.decimalPad)
                                .focused($isAmountFieldFocused)
                        }
                    }
                    .padding()
                    .glassEffect(.regular)
                }
                .padding()
            }
            .hideKeyboard()
            .navigationTitle("Strategies")
            .navigationBarTitleDisplayMode(.inline)
            .background(.backgroundPrimary)
            .onChange(of: isAmountFieldFocused) { oldValue, newValue in
                if oldValue == true && newValue == false {
                    // losing focus and value changes
                }
            }
        }
    }
}

#Preview {
    StrategiesView()
}
