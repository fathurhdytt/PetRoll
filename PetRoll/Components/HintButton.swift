import SwiftUI

enum HintType {
    case iconOnly
    case withCoin
}

struct HintButton: View {
    let type: HintType // Menggunakan enum agar lebih jelas
    var hintCount: Int? // Jumlah hint yang tersedia
    
    var body: some View {
        switch type {
        case .iconOnly:
            ZStack {
                Image(systemName: "lightbulb.max.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .cornerRadius(120)
                    .symbolEffect(.bounce)
                
                if let count = hintCount, count > 0 {
                    Text("\(count)")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .background(Color("SecondaryColor"))
                        .clipShape(Circle())
                        .offset(x: 16, y: -16)
                }
            }
        
        case .withCoin:
            HStack(alignment: .top, spacing: 8) {
                Image("koin")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .overlay(
                        Text("\(hintCount ?? 0)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Black"))
                    )
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        HintButton(type: .iconOnly, hintCount: 3)
        HintButton(type: .withCoin, hintCount: 3)
    }
    .padding()
}
