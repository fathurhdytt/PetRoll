import SwiftUI

struct LifeBar: View {
    var lifeCount: Int = 3 // Variabel jumlah nyawa
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<3, id: \.self) { index in
                Image(systemName: index < lifeCount ? "heart.fill" : "heart") // Tampilkan heart.fill jika masih ada nyawa
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color("PrimaryColor"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color("White"))
        .cornerRadius(16)
    }
}

#Preview {
    VStack {
        LifeBar(lifeCount: 3) // 3 nyawa
        LifeBar(lifeCount: 2) // 2 nyawa
        LifeBar(lifeCount: 1) // 1 nyawa
        LifeBar(lifeCount: 0) // 0 nyawa
    }
}
