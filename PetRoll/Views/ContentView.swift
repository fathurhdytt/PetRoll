import SwiftUI

struct ContentView: View {
    @StateObject private var petViewModel = PetViewModel()
    @State private var position = CGSize.zero
    @GestureState private var dragOffset = CGSize.zero
    @StateObject private var locationManager = LocationManager()
    @State private var goToPreview = false
    
    @State private var path = NavigationPath()
    
    @State private var isMuted = false
    
    @StateObject private var soundController = SoundController()

    @State private var petName: String = "" {
        didSet {
            // Simpan nama pet ke UserDefaults setiap kali petName berubah
            UserDefaults.standard.set(petName, forKey: "petName")
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Image("BackgroundImg")
                    .resizable()
                    .ignoresSafeArea()

                VStack(spacing: 8) {
                    // Lokasi + Tombol
                    HStack(alignment: .center, spacing: 16) {
                        Button(action: {
                            soundController.toggleMute()
                            isMuted.toggle()
                        }){
                            PrimaryButton(image: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill", isFullWidth: false)
                        }

                        OutsideLocPanel(isLocationActive: locationManager.isAtBusStop)

                        HintButton(type: .iconOnly, hintCount: petViewModel.petStatus.hint)
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

                    Gauge(value: petViewModel.petStatus.health, in: 0...1) {
                        Text("Health Bar ❤️")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(Color("White"))
                    .cornerRadius(16)
                    
                    // TextField untuk nama pet
                    TextField("Masukkan nama pet", text: $petName)
                        .padding()
                        .background(Color("White"))
                        .cornerRadius(16)
                        .multilineTextAlignment(.center)  // Agar teks dalam TextField rata tengah
                        .onChange(of: petName) { newValue in
                            // Simpan nama pet ke UserDefaults setiap kali petName berubah
                            UserDefaults.standard.set(newValue, forKey: "petName")
                        }

                    Spacer()

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
                                        withAnimation(.spring()) {
                                            position = .zero
                                        }
                                    }
                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    .frame(height: 300)

                    Spacer()

                    HStack {
                        Button {
                            goToPreview = true
                        } label: {
                            PrimaryButton(text: "Kuis")
                        }

                        Button {
                            petViewModel.feed(isLocated: locationManager.isAtBusStop)
                        } label: {
                            PrimaryButton(text: "Makan", image: "fork.knife")
                        }
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $goToPreview) {
                PreviewQuizView(
                    isLocated: .constant(locationManager.isAtBusStop),
                    petViewModel: petViewModel,
                    path: $path // ✅ ini yang benar!
                )
            }

        }

        .onAppear {
            soundController.playMusic()
            
            // Ambil nama pet dari UserDefaults saat tampilan muncul
            if let savedName = UserDefaults.standard.string(forKey: "petName") {
                petName = savedName
            }
        }
        .environment(\.dynamicTypeSize, .medium)
    }
}

// Preview
#Preview {
    ContentView()
}
