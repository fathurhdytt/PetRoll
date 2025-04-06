import SwiftUI

struct FinishQuizView: View {
    let score: Int
    let total: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("Kuis Selesai 🎉")
                .font(.largeTitle)
                .bold()

            Text("Skor Kamu: \(score) / \(total)")
                .font(.title2)

            NavigationLink("Coba Lagi", destination: ContentView())
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        .padding()
    }
}

#Preview {
    FinishQuizView(score: 7, total: 10)
}
