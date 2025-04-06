import SwiftUI

struct QuizView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: QuizViewModel
    
    var body: some View {
        ZStack {
            // Background
            Image("BackgroundImg")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                // Header Navigasi dan Hint
                HStack(alignment: .top) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color("PrimaryColor"))
                            .foregroundColor(.white)
                            .cornerRadius(120)
                    }
                    
                    Spacer()
                    
                    HintButton(type: .iconOnly, hintCount: 3)
                }
                
                // Life Bar
                LifeBar(lifeCount: 2)
                
                // Soal & Hint
                VStack(spacing: 16) {
                    HStack {
                        Text("Soal \(viewModel.currentQuestionIndex + 1) dari \(viewModel.quiz.questions.count)")
                            .foregroundColor(.gray)
                        Spacer()
                        Text("Skip")
                            .fontWeight(.bold)
                    }
                    
                    //Timer
                    ProgressView(
                        value: Double(viewModel.currentQuestionIndex + 1),
                        total: Double(viewModel.quiz.questions.count)
                    )
                    
                    Text(viewModel.currentQuestion.question)
                        .font(.system(size: 72, weight: .bold))
                        .frame(height: 160)
                    
                    Text("Hint: \(viewModel.currentQuestion.hint)")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color("White"))
                .cornerRadius(16)
                
                // Input Jawaban
                TextField("Jawabanmu", text: $viewModel.userAnswer)
                    .padding()
                    .background(Color("White"))
                    .cornerRadius(16)
                
                Spacer()
                
                // Tombol Jawab
                Button(action: {
                    viewModel.submitAnswer()
                }) {
                    PrimaryButton(text: "Jawab")
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $viewModel.isFinished) {
            FinishQuizView(
                score: viewModel.score,
                total: viewModel.quiz.questions.count
            )
        }
    }
}

#Preview {
    let sampleQuiz = Quiz(
        quizTitle: "Makanan Indonesia",
        questions: [
            Question(question: "🍚🟡", answer: "nasi kuning", hint: "N A _ I   K _ N _ _ G")
        ]
    )
    
    return QuizView(viewModel: QuizViewModel(quiz: sampleQuiz))
}
