import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Soal \(viewModel.currentQuestionIndex + 1) dari \(viewModel.quiz.questions.count)")
                .font(.headline)

            Text(viewModel.currentQuestion.question)
                .font(.system(size: 60))

            Text("Hint: \(viewModel.currentQuestion.hint)")
                .italic()

            TextField("Jawabanmu", text: $viewModel.userAnswer)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button(action: {
                viewModel.submitAnswer()
            }) {
                PrimaryButton(text: "Jawab")
            }

            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.isFinished) {
            FinishQuizView(score: viewModel.score, total: viewModel.quiz.questions.count)
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
