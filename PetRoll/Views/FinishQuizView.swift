import SwiftUI

struct FinishQuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    @State private var goToRoot = false
    @State private var goToPreview = false
    
    @ObservedObject var petViewModel: PetViewModel
    let score: Int
    let isLocated: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    HintButton(type: .iconOnly, hintCount: 2)
                }
                
                LifeBar(lifeCount: 3)
                
                VStack(spacing: 16) {
                    Text("Hasil")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .frame(width: 154, height: 154)
                        .foregroundColor(Color("PrimaryColor"))
                        .padding()
                    
                    Text("Skor Kamu: \(score)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Black"))
                    
                    Divider()
                    
                    
                    Text("+\(Int((isLocated ? 10 : 5)))% Poin Knowledge")
                        .font(.body)
                        .foregroundColor(Color("Black"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("White"))
                                .stroke(Color("PrimaryColor"), lineWidth: 2)
                        }
                    
                    Text("+10% poin knowledge (jika kamu berada di halte BSD Link)")
                        .font(.body)
                        .foregroundColor(Color("Black"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("PrimaryColor").opacity(0.2))
                        .cornerRadius(16)
                }
                .padding()
                .background(Color("White"))
                .cornerRadius(16)
                
                HStack {
                    Button(action: {
                        // Kembali ke root (misal ContentView)
                        goToRoot = true
                    }) {
                        PrimaryButton(text: "Keluar")
                    }
                    
                    Button(action: {
                        // Restart ke PreviewQuizView
                        goToPreview = true
                    }) {
                        PrimaryButton(text: "Restart")
                    }
                }
                .padding(.top)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.background)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $goToPreview) {
                PreviewQuizView(isLocated: .constant(isLocated), petViewModel: petViewModel)

            }
            .fullScreenCover(isPresented: $goToRoot) {
                ContentView()
            }
            .onAppear {
                petViewModel.learn(score: score, isLocated: isLocated)
            }
        }
    }
}

#Preview {
    FinishQuizView(petViewModel: PetViewModel(), score: 7, isLocated: true)
}
