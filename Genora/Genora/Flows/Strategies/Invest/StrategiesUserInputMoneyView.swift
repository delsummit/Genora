//
//  StrategiesUserInputView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 02/01/2026.
//

import SwiftUI

struct StrategiesUserInputMoneyView: View {
    @Bindable var viewModel: StrategiesViewModel
    @FocusState.Binding var isKeyboardVisible: Bool
    
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
                
                TextField("Enter the value", text: $viewModel.investmentAmount)
                    .textFieldStyle(.plain)
                    .keyboardType(.decimalPad)
                    .focused($isKeyboardVisible)
            }
            .padding()
            .glassEffect(.regular, in: .rect(cornerRadius: 24))
        }
    }
}

#Preview {
    StrategiesView()
}
