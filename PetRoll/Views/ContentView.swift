import SwiftUI

struct ContentView: View {
    @State private var isLocated: Bool = false
    @State public var knowledge: Int = 59
    @State public var hunger: Int = 59
    @State public var health: Double = 0.5
    @State private var isQuizActive: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("BackgroundImg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 8) {
                    HStack(alignment: .center, spacing: 16) {
                        PrimaryButton(image: "speaker.wave.2.fill", isFullWidth: false)
                        HStack {
                            Image(systemName: "mappin.and.ellipse.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 24, height: 24)
                                .padding(4)
                                .foregroundColor(Color("Black"))
                                .symbolEffect(.bounce)
                            Text("Saat ini kamu sedang tidak berada di halte 😔")
                                .font(.footnote)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(8)
                        .background(Color("White"))
                        .cornerRadius(16)
                        
                        HintButton(type: .withCoin ,hintCount: 3)
                    }
                    
                    HStack(spacing: 8) {
                        GaugeGroup(text: "Knowledge", icon: "📖")
                        GaugeGroup(text: "Hunger", icon: "🍽️")
                    }
                    
                    Gauge(value: health, in: 0...1) {
                        Text("Health Bar ❤️")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color("White"))
                    .cornerRadius(16)

                    Spacer()
                    Color.red
                        .frame(maxWidth: 320, maxHeight: 320)
                    Spacer()
                    
                    HStack {
                        NavigationLink(
                            destination: PreviewQuizView(isLocated: $isLocated),
                            label: {
                                PrimaryButton(text: "Kuis")
                            }
                        )

                        Button(action: {
                            if health < 1.0 {
                                health = min(health + 0.05, 1.0)
                            }
                        }) {
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
