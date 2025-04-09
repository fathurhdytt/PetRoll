import SwiftUI

struct FinishQuizView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var goToRoot = false
    @State private var goToPreview = false
    
    @ObservedObject var petViewModel: PetViewModel
    let score: Int
    let isLocated: Bool
    
    @State private var addedKnowledge: Double = 0.0
    
    @Binding var path: NavigationPath

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    HintButton(type: .iconOnly, hintCount: petViewModel.petStatus.hint)
                }
                
                VStack(spacing: 16) {
                    Text("Hasil")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Divider()
                    
                    Image(systemName: "trophy.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
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

                    // Kondisi untuk menampilkan bonus hint
                    if score >= 1 && isLocated {
                        Text("🎉 Bonus 1 hint💡! Karena kamu berada di halte BSD Link.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.green)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text("Kamu bisa dapet hint berada di halte BSD Link 😔")
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
                        // Restart ke PreviewQuizView
                        goToPreview = true
                    }) {
                        PrimaryButton(text: "Kembali")
                    }
                }
                .padding(.top)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.background)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $goToPreview) {
                PreviewQuizView(isLocated: .constant(isLocated), petViewModel: petViewModel, path: $path)
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
        .environment(\.dynamicTypeSize, .medium)
    }
}

#Preview {
    FinishQuizView(petViewModel: PetViewModel(), score: 7, isLocated: true, path: .constant(NavigationPath()))
}
