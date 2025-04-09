import SwiftUI

struct FinishQuizView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var goToRoot = false
    @State private var goToPreview = false
    
    @ObservedObject var petViewModel: PetViewModel
    let score: Int
    let isLocated: Bool
    
    @State private var addedKnowledge: Double = 0.0

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    HintButton(type: .iconOnly)
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
                    
                    
                    Text("+\(Int(addedKnowledge * 100))% Poin Knowledge")
                        .font(.body)
                        .foregroundColor(Color("Black"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("White"))
                                .stroke(Color("PrimaryColor"), lineWidth: 2)
                        }

                    if isLocated {
                        Text("🎉 Bonus! Karena kamu berada di halte BSD Link.")
                            .font(.body)
                            .foregroundColor(Color("Black"))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PrimaryColor").opacity(0.2))
                            .cornerRadius(16)
                    }

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
                let maxScore: Double = 100
                let maxGain = isLocated ? 0.25 : 0.20
                let gain = (Double(score) * maxGain) / maxScore
                addedKnowledge = gain
                petViewModel.learn(score: score, isLocated: isLocated)
            }

        }
    }
}

#Preview {
    FinishQuizView(petViewModel: PetViewModel(), score: 7, isLocated: false)
}
