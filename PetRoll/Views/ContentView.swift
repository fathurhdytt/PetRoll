import SwiftUI

struct ContentView: View {
    @StateObject private var petViewModel = PetViewModel()
    @State private var isLocated: Bool = false
    @State private var position = CGPoint(x: 0, y: 0)

    var body: some View {
        NavigationStack {
            ZStack {
                Image("BackgroundImg")
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 8) {
                    // Lokasi + Tombol
                    HStack(alignment: .center, spacing: 16) {
                        PrimaryButton(image: "speaker.wave.2.fill", isFullWidth: false)

                        HStack {
                            Image(systemName: "mappin.and.ellipse.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(4)
                                .foregroundColor(Color("Black"))
                                .symbolEffect(.bounce)

                            Text("Saat ini kamu sedang tidak berada di halte 😔")
                                .font(.footnote)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color("White"))
                        .cornerRadius(16)

                        HintButton(type: .withCoin ,hintCount: 3)
                    }

                    // Progress Bar
                    HStack(spacing: 8) {
                        GaugeGroup(
                            text: "Knowledge",
                            icon: "📖",
                            progress: Binding(get: {
                                petViewModel.petStatus.knowledge
                            }, set: { _ in })
                        )

                        GaugeGroup(
                            text: "Hunger",
                            icon: "🍽️",
                            progress: Binding(get: {
                                petViewModel.petStatus.hunger
                            }, set: { _ in })
                        )
                    }

                    Gauge(value: (petViewModel.petStatus.health), in: 0...1) {
                        Text("Health Bar ❤️")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color("White"))
                    .cornerRadius(16)

                    Spacer()

                    // 🐶 Animasi Pet yang bisa digeser
                    GeometryReader { geo in
                        animationSequence()
                            .frame(width: 320, height: 300)
                            .offset(x: position.x, y: position.y)
//                            .gesture(
//                                DragGesture()
//                                    .onChanged { value in
//                                        self.position = CGPoint(
//                                            x: value.translation.width,
//                                            y: value.translation.height
//                                        )
//                                    }
//                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    .frame(height: .infinity) // Sesuaikan tinggi area animasi


                    Spacer()

                    // Actions
                    HStack {
                        NavigationLink(
                            destination: PreviewQuizView(isLocated: $isLocated, petViewModel: petViewModel),
                            label: {
                                PrimaryButton(text: "Kuis")
                            }
                        )
                        
                        Button {
                            petViewModel.feed()
                        } label: {
                            PrimaryButton(text: "Makan")
                        }
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
