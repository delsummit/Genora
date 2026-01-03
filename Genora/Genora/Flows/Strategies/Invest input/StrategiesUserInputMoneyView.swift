//
//  StrategiesUserInputView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 02/01/2026.
//

import SwiftUI

struct StrategiesUserInputMoneyView: View {
    @State private var usdtAmount: Double?
    @FocusState private var isAmountFieldFocused: Bool
    
    var body: some View {
        Text("Amount you want to invest")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
        
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
                
                TextField("Enter the value", value: $usdtAmount, format: .number.grouping(.automatic))
                    .textFieldStyle(.plain)
                    .keyboardType(.decimalPad)
                    .focused($isAmountFieldFocused)
            }
            .padding()
            .glassEffect(.regular)
        }
        .onChange(of: isAmountFieldFocused) { oldValue, newValue in
            if oldValue == true && newValue == false {
                // losing focus and value changes
            }
        }
    }
}

#Preview {
    StrategiesView()
}
