//
//  StrategiesSelectedChainsView.swift
//  Genora
//
//  Created by Rostyslav Mukoida on 03/01/2026.
//

import SwiftUI

struct StrategiesSelectedChainsView: View {
    var body: some View {
        Text("Mark preferred chains")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
        
        HStack {
            HStack {
                Text("Selected: any")
                
                Spacer()
            }
            .padding()
            .glassEffect()
            
            Button(action: {}) {
                Image(systemName: "square.and.pencil")
                    .frame(width: 40)
                    .frame(maxHeight: .infinity)
            }
            .buttonStyle(.glass)
        }
    }
}


#Preview {
    StrategiesView()
}
