import SwiftUI

struct FinishQuizView: View {
    @Environment(\.presentationMode) var presentationMode
let score: Int
    let total: Int
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                HintButton(type: .iconOnly, hintCount: 2)
            }
            
            LifeBar(lifeCount: 3)
            
            VStack(spacing:16){
                Text("Hasil")
                    .font(.title)
                    .fontWeight(.bold)

                Divider()
                
                Image(systemName: "trophy.fill")
                    .resizable()
                    .frame(width: 154, height: 154)
                    .foregroundColor(Color("PrimaryColor"))
                    .padding()
                
                Text("Skor Kamu: \(score) / \(total)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Black"))
                
                Divider()
                
                Text("+5% Poin Knowledge")
                    .font(.body)
                    .foregroundColor(Color("Black"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("White"))
                            .stroke(Color("PrimaryColor"), lineWidth: 2)
                            
                    }
                
                Text("+10% poin knowledge (jika kamu berada di halte bsd link")
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
            
            
            // NavigationLink ke PreviewQuizView dengan Binding nilai isLocated
            HStack {
                PrimaryButton(text: "Keluar")
                PrimaryButton(text: "Restart")
            }
            .navigationTitle("Pet Screen")
            .toolbar(.hidden, for: .navigationBar)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.background)
    }
}


#Preview {
    FinishQuizView(score: 7, total: 10)
}
