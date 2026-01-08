//
//  StrategiesView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 14/12/2025.
//

import SwiftUI

struct StrategiesView: View {
    @State private var viewModel = StrategiesViewModel()
    @FocusState private var isKeyboardVisible: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    StrategiesUserInputMoneyView(viewModel: viewModel, isKeyboardVisible: $isKeyboardVisible)

                    Divider()
                        .frame(height: 20)
                    
                    StrategiesChainSelectionView(viewModel: viewModel)
                    
                    Divider()
                        .frame(height: 20)
                    
                    StrategiesAPYSliderView(viewModel: viewModel, isKeyboardVisible: $isKeyboardVisible)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.backgroundSecondary)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0), lineWidth: 1)
                )
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .background(Color.backgroundPrimary.ignoresSafeArea())
            .navigationTitle("Strategies")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isKeyboardVisible {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            isKeyboardVisible = false
                        }
                        .foregroundStyle(.element)
                        .fontWeight(.semibold)
                    }
                }
            }
            .onTapGesture {
                isKeyboardVisible = false
            }
            .onAppear {
                HapticsEngine.shared.prepareHaptics()
            }
        }
    }
}

#Preview {
    StrategiesView()
}
