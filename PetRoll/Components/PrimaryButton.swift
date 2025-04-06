import SwiftUI

struct PrimaryButton: View {
    var text: String?
    var backgroundColor: Color = Color("PrimaryColor")
    var image: String?
    var isFullWidth: Bool = true // default-nya tetap full width

    var body: some View {
        HStack(spacing: 8) {
            if let image = image {
                Image(systemName: image)
                    .foregroundColor(.white)
            }

            if let text = text {
                Text(text)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .frame(maxWidth: isFullWidth ? .infinity : nil)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(text: "Lanjut", image: "chevron.right")
        PrimaryButton(text: "Kembali", image: "chevron.left")
        PrimaryButton(text: "Tanpa Ikon")
        PrimaryButton(image: "speaker.wave.2.fill", isFullWidth: false)
    }
    .padding()
}
