//
//  StrategiesMinTVLView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 10/01/2026.
//

import SwiftUI

struct StrategiesMinTVLView: View {
    @Bindable var viewModel: StrategiesViewModel
    @FocusState.Binding var isKeyboardVisible: Bool
    
    var body: some View {
        Text("Minimum TVL")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
        
        HStack {
            HStack {
                TextField("Example: 1 000 000", text: $viewModel.investmentAmount)
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
