import SwiftUI

struct PreviewQuizView: View {
    @Binding var isLocated: Bool
    @State private var quiz: Quiz?
    @ObservedObject var petViewModel: PetViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Header
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Selamat Datang")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Black"))

                            Text("Selamat datang di Kuis! kamu akan menebak makanan Indonesia dari berbagai emoji 😊")
                                .font(.footnote)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        
                        Spacer()
                        
                        Image("QuizHeadline")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 114, maxHeight: 132)
                    }
                    .background(Color("White"))
                    .cornerRadius(12)
                    
                    // Informasi Lokasi
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(spacing: 16) {
                            Image(systemName: "mappin.and.ellipse.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .padding(8)
                                .background(Color("PrimaryColor"))
                                .foregroundColor(Color("White"))
                                .cornerRadius(120)
                                .symbolEffect(.bounce)
                            
                            Text("Kamu bisa mendapatkan poin tambahan jika mengerjakannya di halte BSD Link loh😉")
                                .font(.body)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("Posisi Kamu:")
                                .font(.body)
                                .foregroundColor(Color("Black"))
                                .multilineTextAlignment(.center)

                            InsideLocPanel(isLocationActive: isLocated)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("White"))
                    .cornerRadius(12)
                    
                    // Detail Kuis
                    VStack(spacing: 16) {
                        HorizontalList(image: "list.bullet", title: "10 Soal", description: "Setiap kali kamu bermain")
                        HorizontalList(image: "stopwatch.fill", title: "2 Menit", description: "Waktu mengerjakan setiap tebak-tebakan")
                        HorizontalList(image: "heart.fill", title: "3 Kali Kesempatan", description: "Mengerjakan kuis ulang dalam 1 hari")
                        HorizontalList(image: "lightbulb.max.fill", title: "Hint Jawaban", description: "Untuk mengetahui petunjuk jawaban")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("White"))
                    .cornerRadius(12)

                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            
            // Tombol Bawah
            VStack(spacing: 20) {
                if let quiz = quiz {
                    NavigationLink(
                        destination: QuizView(
                            viewModel: QuizViewModel(quiz: quiz),
                            petViewModel: petViewModel,
                            isLocated: isLocated
                        )
                    ) {
                        PrimaryButton(text: "Proceed")
                    }
                }
                else {
                    ProgressView("Memuat kuis...")
                        .onAppear {
                            loadQuiz()
                        }
                }
            }
            .padding()
        }
        .background(Color.background)
    }
    
    func loadQuiz() {
        if let loadedQuiz = QuizDataLoader.loadQuiz() {
            self.quiz = loadedQuiz
            print("✅ Quiz berhasil dimuat: \(loadedQuiz.quizTitle)")
        }
    }
}

#Preview {
    PreviewQuizView(isLocated: .constant(true), petViewModel: PetViewModel())
}

