import SwiftUI

struct ContentView: View {
    @StateObject private var petViewModel = PetViewModel()
   // @State private var isLocated: Bool = false
    
    
    //Drag Animasi
    @State private var position = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero
    
    //LocationManager
    @StateObject private var locationManager = LocationManager()

    
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

                        OutsideLocPanel(isLocationActive: locationManager.isAtBusStop)

                        HintButton(type: .iconOnly)
                    }

                    // Progress Bar
                    HStack(spacing: 8) {
                        GaugeGroup(
                            text: "Ilmu",
                            icon: "📖",
                            progress: Binding(get: {
                                petViewModel.petStatus.knowledge
                            }, set: { _ in })
                        )

                        GaugeGroup(
                            text: "Lapar",
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
                        let mood = getMood(from: petViewModel.petStatus.health)
                        
                        AnimationSequence(mood: mood)
                            .frame(width: 320, height: 300)
                            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                            .gesture(
                                DragGesture()
                                    .updating($dragOffset) { value, state, _ in
                                        state = value.translation
                                    }
                                    .onEnded { _ in
                                        // Kembali ke posisi awal
                                        withAnimation(.spring()) {
                                            position = .zero
                                        }
                                    }
                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    .frame(height: 300)

                    Spacer()

                    // Actions
                    HStack {
                        NavigationLink(
                            destination: PreviewQuizView(isLocated: $locationManager.isAtBusStop, petViewModel: petViewModel),
                            label: {
                                PrimaryButton(text: "Kuis")
                            }
                        )

                        Button {
                            petViewModel.feed(isLocated: locationManager.isAtBusStop)

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
        
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                print("📍 onAppear: Checking Location (with delay)")
//                print("🔄 isAtBusStop: \(locationManager.isAtBusStop)")
//
//                if let userLocation = locationManager.userLocation {
//                    print("📍 Lokasi User: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
//                } else {
//                    print("⚠️ User location belum tersedia.")
//                }
//
//                print("🚏 Halte: \(locationManager.busStopCoordinate.coordinate.latitude), \(locationManager.busStopCoordinate.coordinate.longitude)")
//            }
//        }
//        .onReceive(locationManager.$isAtBusStop) { newValue in
//            isLocated = newValue
//            print("🔄 isLocated updated: \(isLocated)")
//        }




    }
        
}

#Preview {
    ContentView()
}
