//
//  HorizontalList.swift
//  PetRoll
//
//  Created by Muhammad Fathur Hidayat on 30/03/25.
//

import SwiftUI

struct HorizontalList: View {
    var image: String
    var title: String
    var description: String
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: image)
                .resizable()
                .frame(width: 16, height: 16)
                .padding()
                .background(Color("PrimaryColor"))
                .foregroundColor(.white)
                .cornerRadius(120)
                .foregroundStyle(.yellow)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(Color("Black"))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil) // Pastikan teks tidak terpotong
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HorizontalList(image: "mappin.and.ellipse.circle.fill", title: "10 Soal", description: "Terdapat 10 soal setiap kali kamu bermain")
}
