//
//  GaugeGroup.swift
//  PetRoll
//
//  Created by Muhammad Fathur Hidayat on 03/04/25.
//

import SwiftUI

struct GaugeGroup: View {
    var text: String
    var icon: String
    var body: some View {
        HStack(spacing:16){
            VStack(spacing: 4){
                Text(text)
                    .font(.caption)
                    .fontWeight(.bold)
                Text(icon)
                    .font(.system(size: 48, weight: .bold, design: .default))
            }
            Color.red
                .frame(maxWidth: 64, maxHeight: 64)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("White"))
        .cornerRadius(16)
    }
}

#Preview {
    GaugeGroup(text: "Hunger", icon: "🍽️")
}
