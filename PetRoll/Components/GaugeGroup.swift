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
    @Binding var progress: Double // Value between 0.0 and 1.0

    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 4) {
                Text(text)
                    .font(.caption)
                    .fontWeight(.bold)

                Text(icon)
                    .font(.system(size: 48, weight: .bold))
            }

            Gauge(value: progress, in: 0...1) {
                EmptyView()
            } currentValueLabel: {
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(Gradient(colors: [Color("PrimaryColor"), Color("PrimaryColor")]))
            .frame(width: 64, height: 64)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("White"))
        .cornerRadius(16)
    }
}


#Preview {
    // Dummy wrapper to provide @State for the binding
    struct PreviewWrapper: View {
        @State private var sampleProgress: Double = 0.67

        var body: some View {
            GaugeGroup(text: "Hunger", icon: "🍽️", progress: $sampleProgress)
        }
    }

    return PreviewWrapper()
}
