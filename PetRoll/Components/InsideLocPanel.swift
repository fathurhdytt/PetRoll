//
//  InsideLocPanel.swift
//  PetRoll
//
//  Created by Muhammad Fathur Hidayat on 31/03/25.
//

import SwiftUI

struct InsideLocPanel: View {
    var isLocationActive: Bool
    var body: some View {
        if(isLocationActive){
            Text("Hore Kamu sedang berada di halte 🎉")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.green)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        else {
            Text("Saat ini kamu sedang tidak berada di halte 😔")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Black"))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("PrimaryColor").opacity(0.1))
                .cornerRadius(8)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
        
    }
}

#Preview {
    InsideLocPanel(isLocationActive: true)
    InsideLocPanel(isLocationActive: false)
}
