import Foundation

class QuizViewModel: ObservableObject {
    @Published var quiz: Quiz
    @Published var currentQuestionIndex = 0
    @Published var userAnswer = ""
    @Published var score = 0
    @Published var isFinished = false
    private var randomizedQuestions: [Question] = []
    
    var totalQuestions: Int {
        randomizedQuestions.count
    }


    init(quiz: Quiz) {
        self.quiz = quiz
        self.randomizedQuestions = Array(quiz.questions.shuffled().prefix(10))
    }

    var currentQuestion: Question {
        randomizedQuestions[currentQuestionIndex]
    }

    func submitAnswer() {
        let cleaned = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if cleaned == currentQuestion.answer.lowercased() {
            score += 1
        }

        if currentQuestionIndex < randomizedQuestions.count - 1 {
            currentQuestionIndex += 1
            userAnswer = ""
        } else {
            isFinished = true
        }
    }
    
    
}
