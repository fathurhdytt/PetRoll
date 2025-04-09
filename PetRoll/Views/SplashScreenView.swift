import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                ContentView() // Ganti dengan view utama kamu
            } else {
                ZStack {
                    Image("SplashScreen")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()

                    VStack {
                        Spacer()
                            .frame(height: 100) // ini menggeser teks ke atas sedikit
                        VStack(spacing: 20) {
                            Text("Halo! Aku teman baru mu!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.center)
                            Text("Aku akan menemanimu selama menunggu BSD Link! Aku harap kamu tidak bosan ya😉")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.center)
                        }
                        .padding(24)
                        
                        Spacer()
                    }
                }
                .background(Color("BackgroundColor"))
            }
        }
        .onAppear {
            // Delay 2 detik
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .environment(\.dynamicTypeSize, .medium)
    }
}

#Preview {
    SplashScreenView()
}
