import Foundation
import Combine

class QuizViewModel: ObservableObject {
    @Published var quiz: Quiz
    @Published var currentQuestionIndex = 0
    @Published var userAnswer = ""
    @Published var score = 0
    @Published var isFinished = false
    @Published var timeRemaining = 10.0 // Mulai dari 10 detik
    
    private var randomizedQuestions: [Question] = []
    private var timer: Timer?
    
    let totalTimePerQuestion: Double = 10.0

    var totalQuestions: Int {
        randomizedQuestions.count
    }

    var currentQuestion: Question {
        randomizedQuestions[currentQuestionIndex]
    }

    init(quiz: Quiz) {
        self.quiz = quiz
        self.randomizedQuestions = Array(quiz.questions.shuffled().prefix(10))
        startTimer()
    }

    func submitAnswer() {
        timer?.invalidate()
        
        let cleaned = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if cleaned == currentQuestion.answer.lowercased() {
            // Skor dihitung berdasarkan sisa waktu (maksimal 10 poin)
            let bonus = Int(timeRemaining.rounded())
            score += bonus
        }

        nextQuestion()
    }

    func startTimer() {
        timeRemaining = totalTimePerQuestion
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] t in
            guard let self = self else { return }
            self.timeRemaining -= 0.1
            if self.timeRemaining <= 0 {
                t.invalidate()
                self.nextQuestion() // Auto-skip
            }
        }
    }

    func nextQuestion() {
        userAnswer = ""
        if currentQuestionIndex < randomizedQuestions.count - 1 {
            currentQuestionIndex += 1
            startTimer()
        } else {
            isFinished = true
        }
    }

    deinit {
        timer?.invalidate()
    }
}
